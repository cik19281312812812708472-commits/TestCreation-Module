import Foundation
import PythonKit

public enum PythonEnvironment {
    private static let setup: Void = {
        guard let resourceURL = Bundle.module.resourceURL else {
            print("❌ Error: Bundle.module.resourceURL is nil.")
            return
        }

        // 1. Locate Python.framework and python3.12 directly in resources
        let frameworkURL = resourceURL.appendingPathComponent("Python.framework")
        let altFrameworkURL = resourceURL.appendingPathComponent("Resources/Python.framework")
        let resolvedFrameworkURL = FileManager.default.fileExists(atPath: frameworkURL.path) ? frameworkURL : altFrameworkURL

        let stdLibURL = resourceURL.appendingPathComponent("python3.12")
        let altStdLibURL = resourceURL.appendingPathComponent("Resources/python3.12")
        let resolvedStdLibURL = FileManager.default.fileExists(atPath: stdLibURL.path) ? stdLibURL : altStdLibURL

        guard FileManager.default.fileExists(atPath: resolvedFrameworkURL.path) else {
            print("❌ Error: Could not find Python.framework in resource bundle.")
            return
        }

        guard FileManager.default.fileExists(atPath: resolvedStdLibURL.path) else {
            print("❌ Error: Could not find python3.12 standard library folder.")
            return
        }

        // 2. Resolve exact binary path
        let binaryPath = resolvedFrameworkURL.appendingPathComponent("Python").path

        guard FileManager.default.fileExists(atPath: binaryPath) else {
            print("❌ Critical Error: Python binary not found at: \(binaryPath)")
            return
        }

        let stdLibPath = resolvedStdLibURL.path
        let dynloadPath = "\(stdLibPath)/lib-dynload"

        // 3. EXPLICITLY set the environment variable first (PythonKit checks this directly)
        setenv("PYTHON_LIBRARY", binaryPath, 1)
        
        // 4. Then invoke PythonLibrary registration and paths
        PythonLibrary.useLibrary(at: binaryPath)
        setenv("PYTHONHOME", stdLibPath, 1)
        setenv("PYTHONPATH", "\(stdLibPath):\(dynloadPath)", 1)

        print("✅ Python environment successfully initialized and registered to PythonKit!")
    }()

    public static func initialize() {
        _ = setup
    }
}

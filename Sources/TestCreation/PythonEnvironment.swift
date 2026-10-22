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

        // 2. Point directly to the binary inside the framework
        let binaryPath = resolvedFrameworkURL.appendingPathComponent("Python").path

        guard FileManager.default.fileExists(atPath: binaryPath) else {
            print("❌ Critical Error: Python binary not found at: \(binaryPath)")
            return
        }

        let stdLibPath = resolvedStdLibURL.path
        let dynloadPath = "\(stdLibPath)/lib-dynload"

        // 3. Configure PythonKit and standard library paths
        PythonLibrary.useLibrary(at: binaryPath)
        setenv("PYTHONHOME", stdLibPath, 1)
        setenv("PYTHONPATH", "\(stdLibPath):\(dynloadPath)", 1)

        print("✅ Python environment successfully initialized from Python.framework!")
    }()

    public static func initialize() {
        _ = setup
    }
}

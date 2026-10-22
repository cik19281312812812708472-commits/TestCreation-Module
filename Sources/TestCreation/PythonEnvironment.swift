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

        // 2. Target the exact real binary inside Versions/Current/ (bypassing symlink loops)
        let binaryPath = resolvedFrameworkURL
            .appendingPathComponent("Versions/Current/Python")
            .path
        
        // Fallback to direct path if 'Versions/Current' structure differs
        let finalBinaryPath = FileManager.default.fileExists(atPath: binaryPath) ? binaryPath : resolvedFrameworkURL.appendingPathComponent("Python").path

        guard FileManager.default.fileExists(atPath: finalBinaryPath) else {
            print("❌ Critical Error: Python binary not found at: \(finalBinaryPath)")
            return
        }

        let stdLibPath = resolvedStdLibURL.path
        let dynloadPath = "\(stdLibPath)/lib-dynload"

        // 3. Register with PythonKit and set environment variables
        setenv("PYTHON_LIBRARY", finalBinaryPath, 1)
        PythonLibrary.useLibrary(at: finalBinaryPath)
        
        setenv("PYTHONHOME", stdLibPath, 1)
        setenv("PYTHONPATH", "\(stdLibPath):\(dynloadPath)", 1)

        print("✅ Python environment successfully initialized and registered to PythonKit!")
    }()

    public static func initialize() {
        _ = setup
    }
}

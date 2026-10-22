import Foundation
import PythonKit

public enum PythonEnvironment {
    private static let setup: Void = {
        // 1. Locate the framework and standard library inside package resources
        guard let frameworkURL = Bundle.module.url(forResource: "Python", withExtension: "xcframework"),
              let stdLibURL = Bundle.module.url(forResource: "python3.12", withExtension: nil) else {
            print("Error: Could not find Python package resources.")
            return
        }

        // 2. Resolve the precise path to the framework binary slice
        let binaryPath = frameworkURL
            .appendingPathComponent("macos-arm64_x86_64") // Change to match your target slice if needed
            .appendingPathComponent("Python.framework")
            .appendingPathComponent("Python")
            .path

        let stdLibPath = stdLibURL.path
        let dynloadPath = "\(stdLibPath)/lib-dynload"

        // 3. Explicitly tell PythonKit to use this exact binary path
        PythonLibrary.useLibrary(at: binaryPath)

        // 4. Point Python to the bundled standard library paths
        setenv("PYTHONHOME", stdLibPath, 1)
        setenv("PYTHONPATH", "\(stdLibPath):\(dynloadPath)", 1)

        print("Python environment successfully configured via PythonLibrary.useLibrary!")
    }()

    public static func initialize() {
        _ = setup // Forces the thread-safe closure to run once
    }
}

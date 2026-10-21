import Foundation
import PythonKit

public enum PythonEnvironment {
    // static let closures are thread-safe and execute exactly once automatically in Swift
    private static let setup: Void = {
        // 1. Locate the framework and standard library inside package resources
        guard let frameworkURL = Bundle.module.url(forResource: "Python", withExtension: "xcframework"),
              let stdLibURL = Bundle.module.url(forResource: "python3.12", withExtension: nil) else {
            print("Error: Could not find Python package resources.")
            return
        }

        // 2. Resolve paths (match your architecture slice folder name)
        let binaryPath = frameworkURL
            .appendingPathComponent("macos-arm64_x86_64")
            .appendingPathComponent("Python.framework")
            .appendingPathComponent("Python")
            .path

        let stdLibPath = stdLibURL.path
        let dynloadPath = "\(stdLibPath)/lib-dynload"

        // 3. Tell PythonKit where to find the dynamic library and home paths automatically
        setenv("PYTHON_LIBRARY", binaryPath, 1)
        setenv("PYTHONHOME", stdLibPath, 1)
        setenv("PYTHONPATH", "\(stdLibPath):\(dynloadPath)", 1)

        print("Python environment successfully configured for PythonKit!")
    }()

    public static func initialize() {
        _ = setup // Forces the thread-safe closure to run once
    }

    public static func runTest() -> String {
        initialize()

        let math = Python.import("math")
        let result = math.sqrt(225)
        return "Python math.sqrt(225) = \(result)"
    }
}

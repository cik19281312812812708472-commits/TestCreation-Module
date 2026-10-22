import Foundation
import PythonKit

public enum PythonEnvironment {
    private static let setup: Void = {
        // 1. Get the base resource URL of the Swift Package bundle
        guard let resourcesURL = Bundle.module.resourceURL else {
            print("❌ Error: Bundle.module.resourceURL is nil.")
            return
        }

        // 2. Build the path explicitly using resourceURL (bypassing file extension lookups)
        let frameworkURL = resourcesURL
            .appendingPathComponent("Python.xcframework")
            .appendingPathComponent("macos-arm64_x86_64")
            .appendingPathComponent("Python.framework")
            .appendingPathComponent("Python")

        let stdLibURL = resourcesURL.appendingPathComponent("python3.12")
        let dynloadPath = stdLibURL.appendingPathComponent("lib-dynload").path

        // 3. Verify the binary actually exists at this path
        let binaryPath = frameworkURL.path
        if !FileManager.default.fileExists(atPath: binaryPath) {
            print("❌ Critical Error: Python binary not found at path: \(binaryPath)")
            return
        }

        // 4. Force PythonKit to use the verified path
        PythonLibrary.useLibrary(at: binaryPath)

        // 5. Point Python to the standard library
        setenv("PYTHONHOME", stdLibURL.path, 1)
        setenv("PYTHONPATH", "\(stdLibURL.path):\(dynloadPath)", 1)

        print("✅ Python environment successfully loaded from package bundle!")
    }()

    public static func initialize() {
        _ = setup
    }
}

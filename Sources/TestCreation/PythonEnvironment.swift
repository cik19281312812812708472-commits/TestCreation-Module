import Foundation
import PythonKit

public enum PythonEnvironment {
    private static let setup: Void = {
        // 1. Get the base resource URL of the Swift Package bundle
        guard let resourceURL = Bundle.module.resourceURL else {
            print("❌ Error: Bundle.module.resourceURL is nil.")
            return
        }

        // 2. Locate Python.xcframework and python3.12 (handling potential SwiftPM nesting variations)
        let frameworkURL = resourceURL.appendingPathComponent("Python.xcframework")
        let altFrameworkURL = resourceURL.appendingPathComponent("Resources/Python.xcframework")
        
        let resolvedFrameworkURL = FileManager.default.fileExists(atPath: frameworkURL.path) ? frameworkURL : altFrameworkURL

        let stdLibURL = resourceURL.appendingPathComponent("python3.12")
        let altStdLibURL = resourceURL.appendingPathComponent("Resources/python3.12")
        
        let resolvedStdLibURL = FileManager.default.fileExists(atPath: stdLibURL.path) ? stdLibURL : altStdLibURL

        guard FileManager.default.fileExists(atPath: resolvedFrameworkURL.path) else {
            print("❌ Error: Could not find Python.xcframework in resource bundle at: \(resourceURL.path)")
            return
        }

        guard FileManager.default.fileExists(atPath: resolvedStdLibURL.path) else {
            print("❌ Error: Could not find python3.12 standard library folder in resource bundle.")
            return
        }

        // 3. Dynamically check common architecture slice folder names
        let possibleSlices = ["macos-arm64", "macos-arm64_x86_64", "macos-x86_64"]
        var binaryPath: String?

        for slice in possibleSlices {
            let candidatePath = resolvedFrameworkURL
                .appendingPathComponent(slice)
                .appendingPathComponent("Python.framework")
                .appendingPathComponent("Python")
                .path
            
            if FileManager.default.fileExists(atPath: candidatePath) {
                binaryPath = candidatePath
                break
            }
        }

        guard let finalBinaryPath = binaryPath else {
            print("❌ Critical Error: Could not match a valid architecture slice folder inside Python.xcframework.")
            return
        }

        let stdLibPath = resolvedStdLibURL.path
        let dynloadPath = "\(stdLibPath)/lib-dynload"

        // 4. Force PythonKit to use the located framework binary
        PythonLibrary.useLibrary(at: finalBinaryPath)

        // 5. Configure standard library environment variables
        setenv("PYTHONHOME", stdLibPath, 1)
        setenv("PYTHONPATH", "\(stdLibPath):\(dynloadPath)", 1)

        print("✅ Python environment successfully initialized from package bundle!")
    }()

    public static func initialize() {
        _ = setup
    }
}

import Foundation

public struct PythonEnvironment {
    
    public nonisolated(unsafe) static var pythonEnvironmentInitialized: Bool = false
    public static nonisolated(unsafe) var sentenceAnalyzer: SentenceAnalyzer? = nil
    
    
    public static var resourcesLocation: URL {
        
        guard let resourceURL = Bundle.main.resourceURL else {
            print("❌ Error: Bundle.module.resourceURL is nil.")
            return URL(fileURLWithPath: "nill")
        }
        
        
        print("resourceURL: ", resourceURL, ";")
        return resourceURL
    }
    
    
    
    public static func inititize(pythonLib: URL) {
        
        var failed = false
        
        setenv("PYTHON_LIBRARY", URL.toString(pythonLib)!, 1)
        print("pythonlib: ", URL.toString(pythonLib)!)
        
        let temp = callPython(arguments: ["-m", "pip", "list"], proccessName: "Checking resource list").split(separator: " ").map { String($0) }
        ///This includes the version numbers
        ///
        var installedPackages: [String] = []
        
        for package in temp {
            var subsequences = package.split(separator: "\n")
            subsequences.remove(at: 0)
            
            if subsequences.count > 0 {
                if subsequences[0] != "[notice]" && subsequences[0] != "-----------------------" {
                    installedPackages.append(String(subsequences[0]))
                }
            }
        }
        
        
       //print(installedPackages)
        if !UserDefaults.standard.bool(forKey: "installedSentenceTransformers") || !installedPackages.contains("sentence-transformers") {
            failed = PythonEnvironment.installSentenceTransformers()
            failed.toggle()
        }
        
        if !UserDefaults.standard.bool(forKey: "installedTorch") || !installedPackages.contains("torch") {
            failed = PythonEnvironment.installTorch()
            failed.toggle()
        }
        
      
        
        if !failed {
            PythonEnvironment.pythonEnvironmentInitialized = true
            sentenceAnalyzer = SentenceAnalyzer()
        }
        
    }
    
 
    public static func autoInitialize() -> String {
        var pythonLibLoc = shell("-lc", "which python3")
        pythonLibLoc = pythonLibLoc.replacingOccurrences(of: "\n", with: "")
      
        if let pythonLibURL = URL(string: pythonLibLoc)  {
            
            PythonEnvironment.inititize(pythonLib: pythonLibURL)
            return pythonLibLoc
        } else {
            return pythonLibLoc
            //fatalError("Python Not found.")
        }
        
        
    }
    
    static func installSentenceTransformers() -> Bool {
        let process = Process()
        let pipe = Pipe()
        
        // Use python3 to invoke pip securely
        let pythonLibPath = String(cString: getenv("PYTHON_LIBRARY"))
        
        process.executableURL = URL(fileURLWithPath: pythonLibPath)
        // If python3 is elsewhere, you can use "/usr/bin/env" and pass ["python3", "-m", "pip", ...]
        process.arguments = ["-m", "pip", "install", "sentence-transformers"]
        
        // Hook up the pipe to capture standard output and standard error
        process.standardOutput = pipe
        process.standardError = pipe
        
        do {
            print("Installing sentence-transformers via pip...")
            try process.run()
            
            // Read the output stream as it installs
            let fileHandle = pipe.fileHandleForReading
            let data = fileHandle.readDataToEndOfFile()
            
            process.waitUntilExit()
            
            if let output = String(data: data, encoding: .utf8) {
                print(output)
            }
            
            // Check if it exited successfully (status 0)
            let success = process.terminationStatus == 0
            if success {
                print("Successfully installed sentence-transformers!")
            } else {
                print("Installation failed with exit code: \(process.terminationStatus)")
            }
            UserDefaults.standard.set(true, forKey: "installedSentenceTransformers")
            return success
            
        } catch {
            print("Failed to start pip process: \(error)")
            return false
        }
    }
    static func installTorch() -> Bool {
        let process = Process()
        let pipe = Pipe()
        
        // Use python3 to invoke pip securely
        let pythonLibPath = String(cString: getenv("PYTHON_LIBRARY"))
        
        process.executableURL = URL(fileURLWithPath: pythonLibPath)
        // If python3 is elsewhere, you can use "/usr/bin/env" and pass ["python3", "-m", "pip", ...]
        process.arguments = ["-m", "pip", "install", "torch"]
        
        // Hook up the pipe to capture standard output and standard error
        process.standardOutput = pipe
        process.standardError = pipe
        
        do {
            print("Installing torch via pip...")
            try process.run()
            
            // Read the output stream as it installs
            let fileHandle = pipe.fileHandleForReading
            let data = fileHandle.readDataToEndOfFile()
            
            process.waitUntilExit()
            
            if let output = String(data: data, encoding: .utf8) {
                print(output)
            }
            
            // Check if it exited successfully (status 0)
            let success = process.terminationStatus == 0
            if success {
                print("Successfully installed sentence-transformers!")
            } else {
                print("Installation failed with exit code: \(process.terminationStatus)")
            }
            UserDefaults.standard.set(true, forKey: "installedTorch")
            return success
            
        } catch {
            print("Failed to start pip process: \(error)")
            return false
        }
    }
}

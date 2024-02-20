//
//  FileImporter.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/20/24.
//

import Foundation
import UIKit
import UniformTypeIdentifiers
import MobileCoreServices

extension GameViewController {
    func showDocumentPicker() {
        let documentPicker =
        UIDocumentPickerViewController(forOpeningContentTypes: [.item])
        documentPicker.delegate = self
        
        // Set the initial directory.
        documentPicker.directoryURL = .documentsDirectory
        
        // Present the document picker.
        present(documentPicker, animated: true, completion: nil)
    }
}

extension GameViewController: UIDocumentPickerDelegate {
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print("didPickDocuments: \(urls)")
        
        guard let url = urls.first else {return}
        
        var tempURL = URL(fileURLWithPath: NSTemporaryDirectory())
        // Apend filename (name+extension) to URL
        tempURL.appendPathComponent(url.lastPathComponent)
        
        if url.startAccessingSecurityScopedResource() {
            if let data = try? Data(contentsOf: url) {
                let filename = url.lastPathComponent
                
                print("Data Byte", data)
                print("filename", filename)
                
                do {
                    try data.write(to: tempURL, options: [.atomic, .completeFileProtection])
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            url.stopAccessingSecurityScopedResource()
        }
        
        gameSceneController.parseNbt(path: tempURL.path())
    }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        print("didPickDocument: \(url)")
        gameSceneController.parseNbt(path: url.path())
    }
}

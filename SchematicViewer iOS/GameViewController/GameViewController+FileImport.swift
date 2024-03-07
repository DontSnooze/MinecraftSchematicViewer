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
        
        Task {
            await handleDocumentPicked(path: tempURL.path())
        }
    }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        print("didPickDocument: \(url)")
        Task {
            await handleDocumentPicked(path: url.path())
        }
    }
    
    func handleDocumentPicked(path: String) async {
        guard 
            path.hasSuffix(".schem"),
            let filename = URL(string: path)?.lastPathComponent
        else {
            let alert = UIAlertController(title: "Schematic file error", message: "Please upload a '.schem' file", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            return
        }
        
        let alert = UIAlertController(title: "Import", message: "Load file: \(filename)?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { _ in
            Task {
                await self.parseSchem(path: path)
            }
        }))
        
        present(alert, animated: true)
    }
    
    func parseSchem(path: String) async {
        self.showLoadingTreatment()
        await gameSceneController.parseNbt(path: path)
        self.showLoadingTreatment(false)
    }
}

//
//  FIleManager-Directory.swift
//  HotProspects
//
//  Created by Brandon Glenn on 1/24/22.
//

import Foundation
import CoreText

extension FileManager {
    
    private func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    //-------------------------------------------------------------------
    func decode<T:Decodable> (from location: String, type: T.Type) throws -> T {
        
        do {
            let data = try Data(contentsOf: getDocumentsDirectory().appendingPathComponent(location))
            let decodedData = try JSONDecoder().decode(type, from: data)
            return decodedData

        } catch {
            throw error
        }
    }
    
    //-------------------------------------------------------------------
    func encode<T:Encodable>(content: T, to location: String) {
         
        // get directory
        let directory = getDocumentsDirectory().appendingPathComponent(location)
        
        do  {
            let encodedData = try JSONEncoder().encode(content)
            try encodedData.write(to: directory, options: .atomic)
        } catch {
            // Do something Better - quick fix
            fatalError()
        }
        
        
    }
}

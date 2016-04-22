/**
* Copyright IBM Corporation 2016
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

import Foundation
import CouchDB
import SwiftyJSON
import CFEnvironment

public struct Configuration {

  public enum Error: ErrorProtocol {
    case IO(String)
  }

  // Instance constants
  let configurationFile = "config.json"
  let appEnv: AppEnv

  init() throws {
    // Generate file path for config.json
    let filePath = #file
    let components = filePath.characters.split(separator: "/").map(String.init)
    let notLastThree = components[0..<components.count - 3]
    let finalPath = "/" + notLastThree.joined(separator: "/") + "/\(configurationFile)"

    if let configData = NSData(contentsOfFile: finalPath) {
      let configJson = JSON(data: configData)
      appEnv = try CFEnvironment.getAppEnv(configJson)
      return
    }
    throw Error.IO("Failed to read/parse the contents of the '\(configurationFile)' configuration file.")
  }

  func getDatabase(dbName: String) throws -> Database {
    if let couchDBCredentials = appEnv.getService("Cloudant NoSQL DB-fz")?.credentials {
      if let host = couchDBCredentials["host"].string,
        user = couchDBCredentials["username"].string,
        password = couchDBCredentials["password"].string {
        //port = couchDBCredentials["port"].int {
        //TODO Update port value
          let port = 80
          let connProperties = ConnectionProperties(hostName: host, port: Int16(port), secured: false, userName: user, password: password)
          let dbClient = CouchDBClient(connectionProperties: connProperties)
        return dbClient.database(dbName)
      }
    }
    throw Error.IO("Failed to obtain database service and/or credentials.")
  }
}
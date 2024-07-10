//
//  User.swift
//  SaveNumber
//
//  Created by Ashish Augustine on 2024/5/14.
//

import Foundation

/**
 id                String  @id @default(cuid())
 name              String?
 myNumber          Int?
 githubAccessToken String?
 githubId          Int?    @unique

 */
struct User: Codable {
  var id: String
  var name: String?
  var myNumber: String?
  var githubAccessToken: String?
  var githubId: Int?
}

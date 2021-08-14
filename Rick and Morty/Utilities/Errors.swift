//
//  Errors.swift
//  Rick and Morty
//
//  Created by Kate on 28.07.2021.
//

import Foundation

enum Errors: String, Error {
    case URLError = "Invalid URL"
    case clientError = "Unable to complete your request due to a client error. Please check your internet connection and try again"
    case serverError = "Invalid response from the server"
    case dataError = "Invalid data recieved from the server. Please try again."
    case decodeError = "The JSON data could not be decoded correctly for its Swift model type."
}

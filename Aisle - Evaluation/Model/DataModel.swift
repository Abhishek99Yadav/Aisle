//
//  DataModel.swift
//  Aisle - Evaluation
//
//  Created by Abhishek Yadav on 23/08/23.
//

import Foundation
//struct Profile: Codable {
//    let avatar: String
//    let firstName: String
//
//    enum CodingKeys: String, CodingKey {
//        case avatar
//        case firstName = "first_name"
//    }
//}
//
//struct GeneralInformation: Codable {
//    let age: Int
//    let dateOfBirth: String
//    let firstName: String
//    let gender: String
//    let height: Int
//    let location: Location
//    // Add more properties as needed
//
//    struct Location: Codable {
//        let full: String
//        let summary: String
//    }
//}
//
//struct Preference: Codable {
//    let answerId: Int
//    let id: Int
//    let preferenceQuestion: PreferenceQuestion
//    let value: Int
//
//    struct PreferenceQuestion: Codable {
//        let firstChoice: String
//        let secondChoice: String
//    }
//}
//
//struct Work: Codable {
//    let experience: Experience
//    let fieldOfStudy: FieldOfStudy
//    let highestQualification: HighestQualification
//    let industry: Industry
//
//    enum CodingKeys: String, CodingKey {
//        case experience = "experience_v1"
//        case fieldOfStudy = "field_of_study_v1"
//        case highestQualification = "highest_qualification_v1"
//        case industry = "industry_v1"
//    }
//    struct FieldOfStudy: Codable {
//        let id: Int
//        let name: String
//        // ...
//    }
//
//    struct HighestQualification: Codable {
//        let id: Int
//        let name: String
//        // ...
//    }
//
//    struct Industry: Codable {
//        let id: Int
//        let name: String
//        // ...
//    }
//
//    struct Experience: Codable {
//        let id: Int
//        let name: String
//        let nameAlias: String
//
//        // ...
//    }
//
//    // ... (Rest of your code)
//
//    struct Experience: Codable {
//        let id: Int
//        let name: String
//        let nameAlias: String
//
//        enum CodingKeys: String, CodingKey {
//            case id
//            case name
//            case nameAlias = "name_alias"
//        }
//    }
//
//    // Add more nested structs as needed
//}
//
//struct User: Codable {
//    let approvedTime: String
//    let disapprovedTime: String
//    let generalInformation: GeneralInformation
//    let hasActiveSubscription: Int
//    let icebreakers: String?
//    // Add more properties as needed
//
//    enum CodingKeys: String, CodingKey {
//        case approvedTime = "approved_time"
//        case disapprovedTime = "disapproved_time"
//        case generalInformation = "general_information"
//        case hasActiveSubscription = "has_active_subscription"
//        case icebreakers
//    }
//}
//
//struct Root: Codable {
//    let likes: Likes
//    let invites: Invites
//
//    struct Likes: Codable {
//        let canSeeProfile: Int
//        let likesReceivedCount: Int
//        let profiles: [Profile]
//
//        enum CodingKeys: String, CodingKey {
//            case canSeeProfile = "can_see_profile"
//            case likesReceivedCount = "likes_received_count"
//            case profiles
//        }
//    }
//
//    struct Invites: Codable {
//        let pendingInvitationsCount: Int
//        let profiles: [User]
//
//        enum CodingKeys: String, CodingKey {
//            case pendingInvitationsCount = "pending_invitations_count"
//            case profiles
//        }
//    }
//}

struct Profile: Codable {
    let avatar: String
    let firstName: String
    
    enum CodingKeys: String, CodingKey {
        case avatar
        case firstName = "first_name"
    }
}

struct GeneralInformation: Codable {
    let age: Int
    let dateOfBirth: String
    let firstName: String
    let gender: String
    let height: Int
    let location: Location
    
    struct Location: Codable {
        let full: String
        let summary: String
    }
}

struct Preference: Codable {
    let answerId: Int
    let id: Int
    let preferenceQuestion: PreferenceQuestion
    let value: Int
    
    struct PreferenceQuestion: Codable {
        let firstChoice: String
        let secondChoice: String
    }
}
struct Experience: Codable {
    let id: Int
    let name: String
    let nameAlias: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case nameAlias = "name_alias"
    }
}

struct Work: Codable {
    let experience: Experience
    let fieldOfStudy: FieldOfStudy
    let highestQualification: HighestQualification
    let industry: Industry
    
    enum CodingKeys: String, CodingKey {
        case experience = "experience_v1"
        case fieldOfStudy = "field_of_study_v1"
        case highestQualification = "highest_qualification_v1"
        case industry = "industry_v1"
    }
    
    struct FieldOfStudy: Codable {
        let id: Int
        let name: String
        // ...
    }

    struct HighestQualification: Codable {
        let id: Int
        let name: String
        // ...
    }

    struct Industry: Codable {
        let id: Int
        let name: String
        // ...
    }
    
    // No redundant Experience struct here
    
    // Add more nested structs as needed
}

struct User: Codable {
    let approvedTime: String
    let disapprovedTime: String
    let generalInformation: GeneralInformation
    let hasActiveSubscription: Int
    let icebreakers: String?
    // Add more properties as needed
    
    enum CodingKeys: String, CodingKey {
        case approvedTime = "approved_time"
        case disapprovedTime = "disapproved_time"
        case generalInformation = "general_information"
        case hasActiveSubscription = "has_active_subscription"
        case icebreakers
    }
}

struct Root: Codable {
    let likes: Likes
    let invites: Invites
    
    struct Likes: Codable {
        let canSeeProfile: Int
        let likesReceivedCount: Int
        let profiles: [Profile]
        
        enum CodingKeys: String, CodingKey {
            case canSeeProfile = "can_see_profile"
            case likesReceivedCount = "likes_received_count"
            case profiles
        }
    }
    
    struct Invites: Codable {
        let pendingInvitationsCount: Int
        let profiles: [User]
        
        enum CodingKeys: String, CodingKey {
            case pendingInvitationsCount = "pending_invitations_count"
            case profiles
        }
    }
}

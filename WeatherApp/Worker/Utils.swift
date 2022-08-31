
import Foundation

class Utils {
    
    static let shared = Utils()
    
    public func specifyError(_ error: NetworkError) -> String {
           switch error {
           case .transportError(let error):
               return error.localizedDescription
           case .serverError(_):
               return "\(error)"
           case .decodingError(let error):
               return" Decoding error: \(error.localizedDescription)"
           case .encodingError(let error):
               return "Encoding error: \(error)"
           default:
               return error.localizedDescription
           }
       }
}

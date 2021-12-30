# sol-swift

# Features
- Sign and send transactions.
- Key pair generation
- RPC configuration.
- SPM integration
- Few libraries required (TweetNACL, Starscream, secp256k1).
- Fully tested (53%)

# Usage

### Initialization
Set the NetworkingRouter and setup your enviroment. You can also pass your own **URLSession** with your own settings. Use this router to initialize the sdk with an object that conforms the SolanaAccountStorage protocol
```swift
let network = NetworkingRouter(endpoint: .devnetSolana)
let solana = Solana(router: network, accountStorage: self.accountStorage)
```

### Keypair generation

SolanaAccountStorage interface is used to return the generated accounts. The actual storage of the accout is handled by the client. Please make sure this account is stored correctly (you can encrypt it on the keychain). The retrived accout is Serializable. Inside Account you will fine the phrase, publicKey and secretKey.

Example using Memory (NOT RECOMEMDED).
```swift
class InMemoryAccountStorage: SolanaAccountStorage {
    
    private var _account: Account?
    func save(_ account: Account) -> Result<Void, Error> {
        _account = account
        return .success(())
    }
    var account: Result<Account, Error> {
        if let account = _account {
            return .success(account)
        }
        return .failure(SolanaError.unauthorized)
    }
    func clear() -> Result<Void, Error> {
        _account = nil
        return .success(())
    }
}
```

Example using KeychainSwift.
```swift
enum SolanaAccountStorageError: Error {
    case unauthorized
}
struct KeychainAccountStorageModule: SolanaAccountStorage {
    private let tokenKey = "Summer"
    private let keychain = KeychainSwift()
    
    func save(_ account: Account) -> Result<Void, Error> {
        do {
            let data = try JSONEncoder().encode(account)
            keychain.set(data, forKey: tokenKey)
            return .success(())
        } catch {
            return .failure(error)
        }
    }

    var account: Result<Account, Error> {
        // Read from the keychain
        guard let data = keychain.getData(tokenKey) else { return .failure(SolanaAccountStorageError.unauthorized)  }
        if let account = try? JSONDecoder().decode(Account.self, from: data) {
            return .success(account)
        }
        return .failure(SolanaAccountStorageError.unauthorized)
    }
    func clear() -> Result<Void, Error> {
        keychain.clear()
        return .success(())
    }
}
```

## Requirements

- iOS 11.0+ / macOS 10.13+ / tvOS 11.0+ / watchOS 3.0+
- Swift 5.3+

## Installation

From Xcode 11, you can use [Swift Package Manager](https://swift.org/package-manager/) to add sol-swift to your project.

- File > Swift Packages > Add Package Dependency
- Add `https://github.com/luma-team/sol-swift`
- Select "brach" with "master"
- Select Solana

import Foundation

public protocol SolanaAccountStorage {
    func save(_ account: Account) -> Result<Void, Error>
    var account: Result<Account, Error> { get }
    func clear() -> Result<Void, Error>
}

public class Solana {
    public let auth: SolanaAccountStorage

    public init(accountStorage: SolanaAccountStorage) {
        self.auth = accountStorage
    }
}

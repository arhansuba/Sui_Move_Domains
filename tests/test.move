import 0x1::Preprocessor;
import 0x1::Signer; 

public fun additional_test_sui_domains() {
    let sui_domains = 0x1::SuiDomains;

    // Test: Geçersiz Domain Kaydı Denemesi
    let invalid_domain_name: string = "";
    let invalid_owner: address = 0x1::Signer::address_of(move_contract.signer);
    let invalid_resolution: vector<u8> = b"127.0.0.1";

    assert(
        !sui_domains.registerDomain(invalid_domain_name, invalid_owner, invalid_resolution),
        201,
        "Geçersiz domain kaydı başarılı oldu."
    );

    // Test: Varolan Domainin Tekrar Kaydı
    assert(
        !sui_domains.registerDomain(domain_name, owner, resolution),
        202,
        "Varolan domainin tekrar kaydı başarılı oldu."
    );

    // Test: Geçersiz Çözünürlük Bilgisi
    let invalid_resolution: vector<u8> = b"invalid_resolution";
    assert(
        !sui_domains.registerDomain("invalid.sui", owner, invalid_resolution),
        203,
        "Geçersiz çözünürlük bilgisi ile domain kaydı başarılı oldu."
    );

    // Test: Token Kazanma ve Kontrol Etme
    let user1: address = 0x1::Signer::address_of(move_contract.signer);
    let user2: address = 0x1::Signer::address_of(create_empty_move_contract().signer);
    let token_amount_user1: u64 = 150;
    let token_amount_user2: u64 = 50;

    sui_domains.earnToken(user1, token_amount_user1);
    sui_domains.earnToken(user2, token_amount_user2);

    assert(
        sui_domains.token_db.rewards[user1] == token_amount_user1,
        204,
        "Token ödülü doğru değil (User 1)."
    );

    assert(
        sui_domains.token_db.rewards[user2] == token_amount_user2,
        205,
        "Token ödülü doğru değil (User 2)."
    );

    // Test: Geçersiz Token Ödülü Talepleri
    let invalid_user: address = 0x1::Signer::address_of(create_empty_move_contract().signer);
    let invalid_token_amount: u64 = 200;

    assert(
        !sui_domains.earnToken(invalid_user, invalid_token_amount),
        206,
        "Geçersiz token ödülü talebi başarılı oldu."
    );

    // Diğer test senaryolarını ekleyin...
}

// Diğer fonksiyonları ekleyin...


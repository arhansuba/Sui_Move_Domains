import 0x1::Preprocessor;
import 0x1::Signer; 

public fun additional_test_sui_domains_2() {
    let sui_domains = 0x1::SuiDomains;

    // Test: Domain Çözünürlük Güncelleme Testi
    let updated_resolution: vector<u8> = b"192.168.0.1";
    
    sui_domains.updateDomainResolution(domain_name, updated_resolution);

    assert(
        sui_domains.getDomainResolution(domain_name) == updated_resolution,
        301,
        "Domain çözünürlük bilgisi güncellenemedi."
    );

    // Test: Kullanıcı Token Bakiye Kontrolü
    let user: address = 0x1::Signer::address_of(move_contract.signer);
    let token_balance: u64 = sui_domains.getTokenBalance(user);

    assert(
        token_balance == (token_amount_user1 + token_amount_user2),
        302,
        "Kullanıcı token bakiyesi doğru değil."
    );

    // Test: Token Transferi Senaryosu
    let user_sender: address = 0x1::Signer::address_of(move_contract.signer);
    let user_receiver: address = 0x1::Signer::address_of(create_empty_move_contract().signer);
    let transfer_amount: u64 = 50;

    sui_domains.transferToken(user_sender, user_receiver, transfer_amount);

    assert(
        sui_domains.getTokenBalance(user_sender) == (token_amount_user1 - transfer_amount),
        303,
        "Token transferi başarılı olmadı (Gönderen)."
    );

    assert(
        sui_domains.getTokenBalance(user_receiver) == transfer_amount,
        304,
        "Token transferi başarılı olmadı (Alıcı)."
    );

    // Diğer test senaryolarını ekleyin...
}

// Diğer fonksiyonları ekleyin...

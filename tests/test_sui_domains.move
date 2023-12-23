import 0x1::Preprocessor;
import 0x1::Signer; 

// Test durumu
public fun test_sui_domains() {
    // SuiDomains modülüne erişim sağla
    let sui_domains = 0x1::SuiDomains;

    // Temel Move kontratı oluştur
    let move_contract = create_empty_move_contract();

    // Test domain adı ve sahibi
    let domain_name: string = "example.sui";
    let owner: address = 0x1::Signer::address_of(move_contract.signer);

    // Test çözünürlük bilgisi
    let resolution: vector<u8> = b"127.0.0.1";

    // Domain kaydı yap
    sui_domains.registerDomain(domain_name, owner, resolution);

    // Kaydedilen bilgileri kontrol et
    assert(sui_domains.isDomainRegistered(domain_name), 101, "Domain kaydı yapılamadı.");
    assert(sui_domains.getDomainOwner(domain_name) == owner, 102, "Sahip bilgisi doğru değil.");
    assert(sui_domains.getDomainResolution(domain_name) == resolution, 103, "Çözünürlük bilgisi doğru değil.");

    // Token ödülü kazanma testi
    let user: address = 0x1::Signer::address_of(move_contract.signer);
    let token_amount: u64 = 100;

    sui_domains.earnToken(user, token_amount);

    // Ödülü kontrol et
    assert(sui_domains.token_db.rewards[user] == token_amount, 104, "Token ödülü doğru değil.");
}

// Temel Move kontratı oluştur
public fun create_empty_move_contract(): &signer {
    let (addr, signers) = Signer::create_unchecked();
    let module = Preprocessor::preprocess_code("module TestModule {}", &signers[0]);
    return &signer(module, addr, 0);
}

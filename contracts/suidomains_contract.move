// Temel Move kontratı .Sui domain kaydı ve çözünürlüğü için
module SuiDomains {

    // .Sui domain kayıtları için veritabanı
    resource DomainDatabase {
        // Her domainin sahip olduğu temel bilgiler
        struct Domain {
            owner: address;
            resolution: vector<u8>;
        }

        // Alan adları ve bunlara ait bilgiler
        // Key: Alan adı, Value: Domain yapısı
        map<string, Domain> domains;

        // Alan adı kayıtlı mı kontrolü
        public fun isDomainRegistered(domain_name: string): bool {
            move_from(copy(domains[domain_name])).is_some()
        }

        // Alan adının sahibini getir
        public fun getDomainOwner(domain_name: string): address {
            move_from(copy(domains[domain_name])).expect("Domain kayıtlı değil.").owner
        }

        // Alan adının çözünürlük bilgisini getir
        public fun getDomainResolution(domain_name: string): vector<u8> {
            move_from(copy(domains[domain_name])).expect("Domain kayıtlı değil.").resolution
        }

        // Alan adını kaydet
        public fun saveDomain(domain_name: string, owner: address, resolution: vector<u8>) {
            move_to(
                &mut domains,
                domain_name,
                Domain { owner, resolution },
            );
        }
    }

    // Token bilgileri için veritabanı
    resource TokenDatabase {
        // Kullanıcıların sahip olduğu token miktarı
        public var balances: map<address, u64>;

        // Kullanıcılara ödül olarak verilen token miktarı
        public var rewards: map<address, u64>;

        // Token transferi yapma fonksiyonu
        public fun transfer(from: address, to: address, amount: u64) {
            let sender_balance = *balances.get_mut(&from).unwrap_or(&0);
            assert(sender_balance >= amount, 101, "Yetersiz bakiye.");

            *balances.get_mut(&from).unwrap() = sender_balance - amount;
            *balances.get_mut(&to).unwrap() += amount;
        }

        // Kullanıcıya ödül olarak token verme fonksiyonu
        public fun rewardUser(user: address, amount: u64) {
            *rewards.get_mut(&user).unwrap() += amount;
        }
    }

    // .Sui domain kayıtları için veritabanı
    public let domain_db: &R<DomainDatabase>;

    // Token entegrasyonu için veritabanı
    public let token_db: &R<TokenDatabase>;

    // Domain kaydı yapma fonksiyonu
    public fun registerDomain(
        domain_name: string,
        owner: address,
        resolution: vector<u8>,
    ) {
        // Alan adının daha önce kayıtlı olup olmadığını kontrol et
        assert(!domain_db.isDomainRegistered(domain_name), 101, "Domain zaten kayıtlı.");

        // Domain kaydını yap
        domain_db.saveDomain(domain_name, owner, resolution);
    }

    // Domain çözünürlüğünü getirme fonksiyonu
    public fun getResolution(domain_name: string): vector<u8> {
        domain_db.getDomainResolution(domain_name)
    }

    // Domain sahibini getirme fonksiyonu
    public fun getOwner(domain_name: string): address {
        domain_db.getDomainOwner(domain_name)
    }

    // Token ödülü kazanma fonksiyonu
    public fun earnToken(user: address, amount: u64) {
        token_db.rewardUser(user, amount);
    }
}

// Domain bilgilerini saklamak için bir veritabanı
resource DomainDatabase {
    // Her domainin sahip olduğu temel bilgiler
    struct Domain {
        owner: address;
        resolution: vector<u8>;
    }

    // Alan adları ve bunlara ait bilgiler
    // Key: Alan adı, Value: Domain yapısı
    map<string, Domain> domains;

    // Alan adı kayıtlı mı kontrolü
    public fun isDomainRegistered(domain_name: string): bool {
        move_from(copy(domains[domain_name])).is_some()
    }

    // Alan adının sahibini getir
    public fun getDomainOwner(domain_name: string): address {
        move_from(copy(domains[domain_name])).expect("Domain kayıtlı değil.").owner
    }

    // Alan adının çözünürlük bilgisini getir
    public fun getDomainResolution(domain_name: string): vector<u8> {
        move_from(copy(domains[domain_name])).expect("Domain kayıtlı değil.").resolution
    }

    // Alan adını kaydet
    public fun saveDomain(domain_name: string, owner: address, resolution: vector<u8>) {
        move_to(
            &mut domains,
            domain_name,
            Domain { owner, resolution },
        );
    }
}

// Temel Move kontratı
module SuiDomains {

    // .Sui domain kayıtları için veritabanı
    public let domain_db: &R<DomainDatabase>;

    // Domain kaydı yapma fonksiyonu
    public fun registerDomain(
        domain_name: string,
        owner: address,
        resolution: vector<u8>,
    ) {
        // Alan adının daha önce kayıtlı olup olmadığını kontrol et
        assert(!domain_db.isDomainRegistered(domain_name), 101, "Domain zaten kayıtlı.");

        // Domain kaydını yap
        domain_db.saveDomain(domain_name, owner, resolution);
    }

    // Domain çözünürlüğünü getirme fonksiyonu
    public fun getResolution(domain_name: string): vector<u8> {
        domain_db.getDomainResolution(domain_name)
    }

    // Domain sahibini getirme fonksiyonu
    public fun getOwner(domain_name: string): address {
        domain_db.getDomainOwner(domain_name)
    }
}

module SuiDomains {

    // Token bilgileri için veritabanı
    resource TokenDatabase {
        // Kullanıcıların sahip olduğu token miktarı
        public var balances: map<address, u64>;

        // Kullanıcılara ödül olarak verilen token miktarı
        public var rewards: map<address, u64>;

        // Token transferi yapma fonksiyonu
        public fun transfer(from: address, to: address, amount: u64) {
            let sender_balance = *balances.get_mut(&from).unwrap_or(&0);
            assert(sender_balance >= amount, 101, "Yetersiz bakiye.");

            *balances.get_mut(&from).unwrap() = sender_balance - amount;
            *balances.get_mut(&to).unwrap() += amount;
        }

        // Kullanıcıya ödül olarak token verme fonksiyonu
        public fun rewardUser(user: address, amount: u64) {
            *rewards.get_mut(&user).unwrap() += amount;
        }
    }

    // Token entegrasyonu için veritabanı
    public let token_db: &R<TokenDatabase>;

    // Token ödülü kazanma fonksiyonu
    public fun earnToken(user: address, amount: u64) {
        token_db.rewardUser(user, amount);
    }

    // Token transferi yapma fonksiyonu
    public fun transferToken(from: address, to: address, amount: u64) {
        token_db.transfer(from, to, amount);
    }
}

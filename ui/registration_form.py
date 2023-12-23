import tkinter as tk

class RegistrationForm:
    def __init__(self, root):
        self.root = root
        self.root.title("Domain Kayıt Formu")

        # Domain kayıt formu elemanları
        self.label_domain_name = tk.Label(root, text="Domain Adı:")
        self.entry_domain_name = tk.Entry(root)

        self.label_owner_name = tk.Label(root, text="Sahip Adı:")
        self.entry_owner_name = tk.Entry(root)

        self.label_owner_email = tk.Label(root, text="Sahip E-Posta:")
        self.entry_owner_email = tk.Entry(root)

        # Kayıt düğmesi
        register_button = tk.Button(root, text="Domain Kaydı Yap", command=self.register_domain)

        # Elemanları düzenle
        self.label_domain_name.pack(pady=10)
        self.entry_domain_name.pack(pady=10)
        self.label_owner_name.pack(pady=10)
        self.entry_owner_name.pack(pady=10)
        self.label_owner_email.pack(pady=10)
        self.entry_owner_email.pack(pady=10)
        register_button.pack(pady=20)

    def register_domain(self):
        domain_name = self.entry_domain_name.get()
        owner_name = self.entry_owner_name.get()
        owner_email = self.entry_owner_email.get()

        print(f"Domain Adı: {domain_name}\nSahip Adı: {owner_name}\nSahip E-Posta: {owner_email}")
        print("Domain Kayıt İşlemi Gerçekleştirildi")

if __name__ == "__main__":
    root = tk.Tk()
    registration_form = RegistrationForm(root)
    root.mainloop()


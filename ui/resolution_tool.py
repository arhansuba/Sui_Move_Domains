import tkinter as tk

class ResolutionTool:
    def __init__(self, root):
        self.root = root
        self.root.title("Domain Çözünürlüğü")

        # Domain çözünürlük aracı elemanları
        label_domain_name = tk.Label(root, text="Domain Adı:")
        entry_domain_name = tk.Entry(root)

        # Çözünürlük düğmesi
        resolve_button = tk.Button(root, text="Çözünürlük Yap", command=self.resolve_domain)

        # Elemanları düzenle
        label_domain_name.pack(pady=10)
        entry_domain_name.pack(pady=10)
        resolve_button.pack(pady=20)

    def resolve_domain(self):
        print("Domain Çözünürlük İşlemi Gerçekleştirildi")

if __name__ == "__main__":
    root = tk.Tk()
    resolution_tool = ResolutionTool(root)
    root.mainloop()

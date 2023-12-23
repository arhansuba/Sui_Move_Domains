import tkinter as tk
from ui.registration_form import RegistrationForm
from ui.resolution_tool import ResolutionTool

class MainWindow:
    def __init__(self, root):
        self.root = root
        self.root.title("Sui Domains")

        registration_button = tk.Button(root, text="Domain Kaydı", command=self.open_registration_form)
        resolution_button = tk.Button(root, text="Domain Çözünürlüğü", command=self.open_resolution_tool)

        registration_button.pack(pady=20)
        resolution_button.pack(pady=20)

    def open_registration_form(self):
        registration_window = tk.Toplevel(self.root)
        registration_form = RegistrationForm(registration_window)

    def open_resolution_tool(self):
        resolution_window = tk.Toplevel(self.root)
        resolution_tool = ResolutionTool(resolution_window)

if __name__ == "__main__":
    root = tk.Tk()
    app = MainWindow(root)
    root.mainloop()

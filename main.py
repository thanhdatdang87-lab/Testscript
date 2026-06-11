import os
from kivy.app import App
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.button import Button
from kivy.uix.label import Label
from kivy.uix.textinput import TextInput

class THG2_ObfuscatorApp(App):
    def build(self):
        self.layout = BoxLayout(orientation='vertical', padding=10, spacing=10)
        
        # Tiêu đề app
        self.title_label = Label(text="🧬 THG2 HUB • OBFUSCATOR 🧬", font_size=20, color=(0, 1, 1, 1))
        self.layout.add(self.title_label)
        
        # Ô nhập tên file
        self.lbl = Label(text="Nhập tên file Lua cần mã hóa (để trong Download):")
        self.layout.add(self.lbl)
        
        self.file_input = TextInput(text="ohhh.lua", multiline=False, size_hint_y=None, height=40)
        self.layout.add(self.file_input)
        
        # Nút bấm chạy
        self.btn = Button(text="BẮT ĐẦU BĂM VM", background_color=(0, 1, 0, 1), font_size=18)
        self.btn.bind(on_press=self.run_obfuscate)
        self.layout.add(self.btn)
        
        # Ô hiển thị Log
        self.log_output = TextInput(text="Hệ thống sẵn sàng...\n", readonly=True, background_color=(0,0,0,1), foreground_color=(0,1,0,1))
        self.layout.add(self.log_output)
        
        return self.layout

    def run_obfuscate(self, instance):
        file_name = self.file_input.text
        self.log_output.text += f"-> Đang tìm file: {file_name}...\n"
        
        input_path = f"/sdcard/Download/{file_name}"
        if os.path.exists(input_path):
            self.log_output.text += "-> Đã tìm thấy file! Đang băm VM...\n"
            
            # Chạy lệnh lua của Prometheus ngầm bên trong APK
            os.system(f"cp {input_path} ./input.lua")
            os.system("lua prometheus-main.lua --config config.lua input.lua")
            
            if os.path.exists("./input.obfuscated.lua"):
                output_file = file_name.replace('.lua', '_Protected.lua')
                os.system(f"echo '-- This file Protected by THG2 >>' > /sdcard/Download/{output_file}")
                os.system(f"cat ./input.obfuscated.lua >> /sdcard/Download/{output_file}")
                self.log_output.text += "[SUCCESS] Đã bọc giáp thành công! File lưu tại mục Download.\n"
            else:
                self.log_output.text += "[ERROR] Prometheus băm thất bại!\n"
        else:
            self.log_output.text += "[ERROR] Không tìm thấy file trong mục Download!\n"

if __name__ == '__main__':
    THG2_ObfuscatorApp().run()
      

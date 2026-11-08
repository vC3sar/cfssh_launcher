import subprocess, re

# Pull shared_prefs
subprocess.run(['adb', '-s', 'R9JT1047S6X', 'shell', 'run-as com.cfssh.launcher cat shared_prefs/FlutterSharedPreferences.xml > /sdcard/prefs.xml'], check=True)
subprocess.run(['adb', '-s', 'R9JT1047S6X', 'pull', '/sdcard/prefs.xml', 'prefs.xml'], check=True)

with open('prefs.xml', 'r', encoding='utf-8') as f:
    content = f.read()

# Replace /live/ch00_0 with /live/ch00_1
new_content = content.replace('/live/ch00_0', '/live/ch00_1')

with open('prefs_new.xml', 'w', encoding='utf-8') as f:
    f.write(new_content)

subprocess.run(['adb', '-s', 'R9JT1047S6X', 'push', 'prefs_new.xml', '/sdcard/prefs_new.xml'], check=True)
subprocess.run(['adb', '-s', 'R9JT1047S6X', 'shell', 'run-as com.cfssh.launcher cp /sdcard/prefs_new.xml shared_prefs/FlutterSharedPreferences.xml'], check=True)
print("Updated prefs to substream ch00_1 successfully")


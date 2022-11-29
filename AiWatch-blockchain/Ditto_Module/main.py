from Ditto_Module.Functions import ModuleInteraction

Functions = ModuleInteraction()
HashList = []

while True:
    try:
        Hash = Functions.RetriveHash("0x9F705D5071D234B837ceF778A78d0044223D006F")
        HashList.append(Hash)
    except:
        break
print(HashList)

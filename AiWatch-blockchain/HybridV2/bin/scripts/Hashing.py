import hashlib
import json

HashList = []


def HashContent(jsonlist):
    dump = json.dumps(jsonlist, sort_keys=True, indent=2)
    jsonhash = hashlib.sha256(dump.encode("utf-8")).hexdigest()
    return jsonhash


def hashToLoad(json_file):
    hash_result = HashContent(json_file)
    HashList.append(hash_result)
    return HashList.pop(0)

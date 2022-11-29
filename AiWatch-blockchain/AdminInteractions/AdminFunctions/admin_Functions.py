from web3 import Web3
from web3.middleware import geth_poa_middleware
from dotenv import load_dotenv
from os.path import join, dirname
import json
import os

dotenv_path = join(dirname(__file__), '.env')
load_dotenv(dotenv_path)


class Contract(object):
    __instance = None

    def __new__(self, w3, address):
        if not self.__instance:
            self.__instance = super(Contract, self).__new__(self)
            with open(join(dirname(__file__), 'abi.json')) as f:
                info_json = json.load(f)
            self.contract = w3.eth.contract(address=address, abi=info_json)
        return self.__instance


class Connection(object):
    __instance = None

    def __new__(cls):
        if not cls.__instance:
            cls.__instance = super(Connection, cls).__new__(cls)
            cls.w3 = Web3(Web3.HTTPProvider(os.environ.get("NODE_ENDPOINT")))
            cls.w3.middleware_onion.inject(geth_poa_middleware, layer=0)
        return cls.__instance


class AdminFunction:

    def __init__(self):
        self.w3 = Connection().w3
        self.contract = Contract(self.w3, os.environ.get("CONTRACT_ADDRESS")).contract
        self.public = os.environ.get("ACCOUNT_PUBLIC")
        self.private = os.environ.get("ACCOUNT_PRIVATE")

    def AddCorresponding(self,key,value):
        Tx = self.contract.functions.newCorresponding(key,value).buildTransaction(
            {"from": self.public, "nonce": self.w3.eth.getTransactionCount(self.public), "gasPrice": self.w3.eth.gas_price})

        signed_tx = self.w3.eth.account.sign_transaction(Tx, self.private)

        self.w3.eth.send_raw_transaction(signed_tx.rawTransaction)

    def RemoveCorresponding(self,sender):
        Tx = self.contract.functions.deleteCorresponding(sender).buildTransaction(
            {"from": self.public, "nonce": self.w3.eth.getTransactionCount(self.public), "gasPrice": self.w3.eth.gas_price})

        signed_tx = self.w3.eth.account.sign_transaction(Tx, self.private)

        self.w3.eth.send_raw_transaction(signed_tx.rawTransaction)
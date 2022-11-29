from web3 import Web3
import json
from web3.middleware import geth_poa_middleware
from dotenv import load_dotenv
from os.path import join, dirname
import os

dotenv_path = join(dirname(__file__), '.env')
load_dotenv(dotenv_path)


class Contract(object):
    __instance = None

    def __new__(self, w3, address):
        if not self.__instance:
            self.__instance = super(Contract, self).__new__(self)
            with open(join(dirname(__file__),'abi.json')) as f:
                info_json = json.load(f)
            self.contract = w3.eth.contract(address=address, abi=info_json)
        return self.__instance


class Connection(object):
    __instance = None

    def __new__(self):
        if not self.__instance:
            self.__instance = super(Connection, self).__new__(self)
            self.w3 = Web3(Web3.HTTPProvider(os.environ.get("NODE_ENDPOINT")))
            self.w3.middleware_onion.inject(geth_poa_middleware, layer=0)
        return self.__instance


def InitConnection():
    my_connection = Connection()
    return my_connection.w3


def InitContract(w3, address):
    my_contract = Contract(w3, address)
    return my_contract.contract


def sendToBlockchain(my_hash):
    w3 = InitConnection()
    contract_address = os.getenv('CONTRACT_ADDRESS')
    account_public = os.getenv('ACCOUNT_PUBLIC')
    account_private = os.getenv('ACCOUNT_PRIVATE')
    contractInstance = InitContract(w3, contract_address)
    sendHash(w3, account_public, account_private, contractInstance, my_hash)


def sendHash(w3, accountPublic, accountPrivate, contract, Hash):
    Tx = contract.functions.StoreInterface(Hash).buildTransaction(
        {"from": accountPublic, "nonce": w3.eth.getTransactionCount(accountPublic), "gasPrice": w3.eth.gas_price})

    signed_tx = w3.eth.account.sign_transaction(Tx, accountPrivate)

    w3.eth.send_raw_transaction(signed_tx.rawTransaction)



import requests

url = "https://api-eu1.tatum.io/v3/blockchain/token/deploy"

payload = {
  "chain": "MATIC",
  "symbol": "MRO",
  "name": "Mirano",
  "totalCap": "10000000",
  "supply": "10000000",
  "digits": 18,
  "address": "0x56eA94630e75bD76c0Bb7AFCBda5aa19EDC50d09",
  "fromPrivateKey": "0x05e150c73f1920ec14caa1e0b6aa09940899678051a78542840c2668ce5080c2",
  "nonce": 0,
  "fee": {
    "gasLimit": "40000",
    "gasPrice": "20"
  }
}

headers = {
  "Content-Type": "application/json",
  "x-testnet-type": "ethereum-ropsten",
  "x-api-key": "f2b97860-d660-446d-8b0c-e3af3d33cc83_100"
}

response = requests.post(url, json=payload, headers=headers)

data = response.json()
print(data)
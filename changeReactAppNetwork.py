import platform
from re import I
import sys
from pprint import pp, pprint

if platform.system() == "Windows":
    filename = ".\\packages\\react-app\\src\\App.jsx"
else:
    filename = "./packages/react-app/src/App.jsx"

networkStruct = {
    "localhost": "localhost",
    "mainnet": "mainnet",
    "kovan": "kovan",
    "rinkeby": "rinkeby",
    "ropsten": "ropsten",
    "goerli": "goerli",
    "xdai": "xdai",
    "matic": "matic",
    "mumbai": "mumbai",
    "localArbitrum": "localArbitrum",
    "localArbitrumL1": "localArbitrumL1",
    "rinkebyArbitrum": "rinkebyArbitrum",
    "arbitrum": "arbitrum",
    "localOptimismL1": "localOptimismL1",
    "localOptimism": "localOptimism",
    "kovanOptimism": "kovanOptimism",
    "optimism": "optimism",
}

def changeNetwork(network):
    with open(filename,'+r', encoding='utf-8') as f:
        t = f.read()
        t = t.replace('const targetNetwork = NETWORKS.ropsten;', 'const targetNetwork = NETWORKS.{};'.format(network))
    
        f.seek(0, 0)
        f.write(t)
        f.truncate()
    print("切换网络到: {}".format(network))

if __name__ == "__main__":
    input = sys.argv[1]

    try:
        network = networkStruct[input]
    except:
        print("请输入正确的网络名。")
        print("请参考：")
        pprint(networkStruct)
    changeNetwork(network)



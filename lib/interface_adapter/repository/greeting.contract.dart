const theGreetingContractAbi = '''
[
    {
      "inputs": [],
      "name": "getCampaignList",
      "outputs": [
        {
          "internalType": "contract ICampaign[]",
          "name": "",
          "type": "address[]"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "getCampaignListAndName",
      "outputs": [
        {
          "internalType": "contract ICampaign[]",
          "name": "",
          "type": "address[]"
        },
        {
          "internalType": "string[]",
          "name": "",
          "type": "string[]"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "contract ICampaign",
          "name": "campaign",
          "type": "address"
        }
      ],
      "name": "getGreetingWordList",
      "outputs": [
        {
          "internalType": "string[]",
          "name": "",
          "type": "string[]"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "contract ICampaign",
          "name": "campaign",
          "type": "address"
        },
        {
          "internalType": "uint256",
          "name": "id",
          "type": "uint256"
        }
      ],
      "name": "getMessageByIdOfCampaign",
      "outputs": [
        {
          "components": [
            {
              "internalType": "uint256",
              "name": "id",
              "type": "uint256"
            },
            {
              "internalType": "address",
              "name": "sender",
              "type": "address"
            },
            {
              "internalType": "address",
              "name": "recipient",
              "type": "address"
            },
            {
              "internalType": "string",
              "name": "greetingWord",
              "type": "string"
            },
            {
              "internalType": "string",
              "name": "bodyURI",
              "type": "string"
            },
            {
              "internalType": "enum ICampaign.MessageStatus",
              "name": "status",
              "type": "uint8"
            },
            {
              "internalType": "bool",
              "name": "isResonanced",
              "type": "bool"
            }
          ],
          "internalType": "struct ICampaign.MessageResponseDto",
          "name": "",
          "type": "tuple"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "contract ICampaign",
          "name": "campaign",
          "type": "address"
        },
        {
          "internalType": "address",
          "name": "who",
          "type": "address"
        },
        {
          "internalType": "enum ICampaign.MessageType",
          "name": "messageType",
          "type": "uint8"
        }
      ],
      "name": "getMessageIdsOfCampaign",
      "outputs": [
        {
          "internalType": "uint256[]",
          "name": "",
          "type": "uint256[]"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "contract ICampaign",
          "name": "campaign",
          "type": "address"
        }
      ],
      "name": "getPricePerMessageInWei",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "price",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "contract ICampaign",
          "name": "campaign",
          "type": "address"
        },
        {
          "internalType": "address",
          "name": "sender",
          "type": "address"
        }
      ],
      "name": "getSelectedGreetingWord",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        },
        {
          "internalType": "string",
          "name": "",
          "type": "string"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "address",
          "name": "address_",
          "type": "address"
        }
      ],
      "name": "isHumanityVerified",
      "outputs": [
        {
          "internalType": "bool",
          "name": "",
          "type": "bool"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "pushCommContractAddress",
      "outputs": [
        {
          "internalType": "address",
          "name": "",
          "type": "address"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "contract ICampaign",
          "name": "campaign_",
          "type": "address"
        }
      ],
      "name": "registerCampaign",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "contract ICampaign",
          "name": "campaign",
          "type": "address"
        },
        {
          "internalType": "uint256",
          "name": "wordIndex",
          "type": "uint256"
        }
      ],
      "name": "selectGreetingWord",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "contract ICampaign",
          "name": "campaign",
          "type": "address"
        },
        {
          "internalType": "address",
          "name": "to",
          "type": "address"
        },
        {
          "internalType": "string",
          "name": "messageURI",
          "type": "string"
        }
      ],
      "name": "send",
      "outputs": [],
      "stateMutability": "payable",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "address",
          "name": "addr_",
          "type": "address"
        }
      ],
      "name": "setChannelAddrOnPush",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "address",
          "name": "addr_",
          "type": "address"
        }
      ],
      "name": "setPushCommContractAddr",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "theGreetingChannelOnPush",
      "outputs": [
        {
          "internalType": "address",
          "name": "",
          "type": "address"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "verifyHumanity",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    }
]
''';

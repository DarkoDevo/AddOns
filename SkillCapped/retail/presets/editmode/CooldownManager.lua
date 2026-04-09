local AddonName, SkillCapped = ...
local SC = SkillCapped

local cdmProfiles = {
    ["DEATHKNIGHT"] = {
        [1] = { -- Blood
            ["PvP"] = "1|JZE9SEJRGIbV7pRZ26HXhmuctpobApfcWhKD7I6CWpKgEBk1RURR0BhZm4RBW1NTSzgVYfazterQVcv+qanvPS7P5dx77sf3Pu+mtV4aDJesjeIUlAv1DNXGVQeOBacH12WoDuzHoMcXcWDXUNmH/QDVgvbDvoPug12FfQs9APse6hW6H/VR6DB0IOjxNuOCxI8gs0qs8egSTaIlc/2nvLfL4wfR5r0CsUysQJ/w9btc7b2Bnoa+5DZVVGLQZX56Id6IT+KL+Cb+BHX50dvYFrh7BOcEchhR8nxirtQF8StIjxNLxBkhm/jm04KFIWKOcAQH54LDhuBo7Hh4y2TormJiNONmusTx7ZhlJUk3RKbA/Ssxk8uEMMlCxSC9i2vRJupVq6tbbEoFUoS4FtE6YCxXTQc11iSiRb3UQPWu1ET7rKdTsmZnFjPZbCSRz6eSE6HJbC6XDEUL0X8=",
            -- ["PvE"] = "",
        },
        [2] = { -- Frost
            ["PvP"] = "1|VZFNSwJRGIVNrSh/QJ5oYbR3k1C0aGO0KWhUah9UIO+EolHSKipsFRT0YUHW0KJf0cciql/Qrq1YFlhGaBr0nhsibZ6Zy8x777nP2fSuOf5Rx7OeG4M0ICXIM+wOyDvkBw/DkG9IBfIGeYGUIVVIEXYnFocgn5BXFMKQOhIfSOhIrdfVlrtRxM+IU+JEYWVgu2G7YHu58ikOQvyYV0RW+OYopoq4/4Ldzl12FYd9/PGKI0Hc1fW5f8GBqOKIJ1gxLrsU0W5iUJHdIS4Ve7ecmORGE8Qq8cjNzQkMcLxAPCnyKSLd63IP9Cg2rhWFacWW/7x/u3lgJKoJTdL/GUPNoCagFTTX+ruJ5XNnWzJaEjJGUyDnNwqLFE/HJUql77IpoWI010wPDXaimlW2VqQlsJ+6qaJq0jqemZjEbTs8m0zOz40ExlOJ9FLAWrZ+AQ==",
            -- ["PvE"] = "",
        },
        [3] = { -- Unholy
            ["PvP"] = "1|PZHfK0NxGIfP5jQrm0mz7V3JXLp16caFEkot0tCJVjSz8+6sFLlQ5me5sdlohST/glzgZrnxN7hwN0VKciXC+3mHm+ec95zvec/7eZ8Nc/U00ptfqwxHDVcwRWzKdf6Jbq+JE3iUJvuTOEzcSOwh9hI3EzdQ9pnYR9xEHCH2k3NOjkMcIG4hdpP9RWzI16lQ1HAnB9DyRbBbE4w8Cgr36J0BsoIyjpT3BaUFQdFC6UJ5Kdh7wDkbL9pxx+hygbuSIH1FHKJaAXUZp0/wu1eUaBg8kBGmLSBE3CZPOvql6FokbsXBD4G/Kki+4weHwB3aEDAuOLoRHH/LR+srgsElwYQJDAkm0drqFkwFBJtvgq2ds86CTPUXyl/V+eqb0Pw6vmbVhJpVl6AJNbAuS/dUtNzb9dH/E9Xn/o0qSWIV0RBWdbp2COEEnMBeBEJg1IAcscemCvSoVa9q9EEj3MJhPjGaSdt2XzKXm53piY1l5xx7ORZfjP8A",
            -- ["PvE"] = "",
        },
    },
    ["WARRIOR"] = {
        [1] = { -- Arms
            ["PvP"] = "1|PdG/SwJhGAdw07bWoPc5rc76CxykH88NRba0JIjtQSGmoVYIpYXJZS2NkalIl0tzuBTFWXOFYTTV3+DWEkTP98qWz917d+/xvN+v2V+wBixPsbyoufoCGSH7TtwkTsmtFVU+4lfiDrFNXCQukGmTkVIaGWniFzJb2FYFNeWVS36BuE3mgxohrhFXycgQlyk0SKFLup0hPiWuEJ8R1+XrmAaGwTjwgTHgxy+7dP1J5j3WCpCwP4TBToTHc+FpXtj9EJ5DWJbAITgSglN0g53BNZAASfrew5x32BcHDeEiorncS1vC9gSYFHbehNwo0LE8xgsbtPDsC3c5kMfyCsQb/oPePJhRnjgjyxTuUu9sge7/eVXvqDGfXtaVF1FJwIin4uSPBJFjHUXYToBFhGm2JGMnzMJfZdIJMm86fbWlm98yUFMHJRgpacDyRCOJeDI5t5xOr65M67Mb65t6OBv+AQ==",
            -- ["PvE"] = "",
        },
        [2] = { -- Fury
            ["PvP"] = "1|NdG9S0JRGAZwk6CG/oAeS7GlCKpbfmT5VfFaWyBEU1NQSGQggUFDJeLNjLKhRZqKS1+uDkEoBNUWBO0R9Q80CM6d59xcfudy7r3nPe/zFjpzVz35Vr6y6HJ0TDyTF5gxrq8QA+KHTELKkClIEKYH9SrkHKZbfWIdQk4hJ5BxJNRzE2YcEoKcQQKQCMSnvtp/gkQhM5A5fGQhcbUXKClSQ8QgIySiyF0q/A+KYBcaP5ifReOCL8NkkIySYcXBCu9QVLxfkxvUf7lWyS0ev7jekXse+s26NfLJn99YbYykeMwR4a2sYxbvdjmcey7SR9ykX5HzK2pka5p7vQTEYw0U7Jr6XrpDq+gstfuxOzDanbV7tXuK6BC8FTdzMmOMSuWcsPMtM3ZmHmeyOnlm2vxPXtS2Tw8qwBFxXCGOi1kbegpRPat8a3lpcyOdltVMZn0t7F3Ibu96kzvJPw==",
            -- ["PvE"] = "",
        },
        [3] = { -- Prot
            ["PvP"] = "1|NZE9S0JxFMbVLpmlGUnic/V6r1mfIGpoi5ZDUFotLQ29iEiSItIYUfaCvY42Sg4tLTaFe9AWTfYFkuaWoIbOOeby4/7v/T/3PPxOxTioB+rGYW3BdLkbLrS+QV7QIMgEjYJ8oABoDDQAiuDtAxQCDYMACoP6QSOgPlASzU8070ExUAI0DvKDhkA2KAqyQAYoaLo81gOPaduCmMBiZFcYr0eCiuBMcCw4EZxKMbfcW0bnBx3uNQma4BczDmP6S56W0ErK4VbupXhQfEqOz/JtUZCSv3gY7z6ZK8l2nLE5h98nCa1zaP9CcCm4ElwLqoJzwQ3j8eUuUdGchrrhhttT/S9oapter2yKm3JfLcvttaJTs1WkpeYMtehVwT4V71fl7DiodqF7COkSwmo0olsyVW2sJ75rPcnW68ZadHUnl8/PbxSLme1ZJ10qlDNb5Vxh10nvpf8A",
            -- ["PvE"] = "",
        },
    },
    ["PALADIN"] = {
        [1] = { -- Holy
            ["PvP"] = "1|JZC9TgJRFISR8AoWQ7U8AKWNrY2Nyo8+AAYLZRPIuDGxI+sKakK1gFQaBVFIkGx8C97AgsLCdqGiI+GcQzPn3nMnk/lukKq/7forv5dNJ3ZKAbgGP8B38AR8BY/BI3mZzxD/IN5T0yM4BkfgF/gJDsGBrh9UnsB/nU2Ve/AFLIB5vTVEpiHiayxO5XjVgRfpbKt0EYc6Qyz+1NwCzfSs0hOZ6Pp7KfJ7l04kvfN+JtAsL9rGTcNkYAGWZhEW7nSkkVWVwuMtiUEZ4FqQrGTeYAsKqeyC1Rcs+4qhvzorVi5d96BUq12U953Dqnvr5G5yGw==",
            -- ["PvE"] = "",
        },
        [2] = { -- Prot
            ["PvP"] = "1|TdA9T8JQFMZxJGzqSvKUpcVRhzM7mZgY3xKqLI4SRYOiEKUFBbXUGsQBw8YmFT8Di4kLX8MVE0e/geepHVx+t2lv7j39BykvTIcpf7ACpwHnCuJjMgdpQ+6NxMzsJSSAdPi4AGlBHIgHafDFFqQPuYXcQOqQHtx5iJ5wDWlCXN2yv0bW4S5y3VRORpBnSBf1H0zH+LLgNPnNxuSd6wbkies2yUEeue6QXZLnES/kjQxJSF6NRBLHipElBcVaIkdkSELCfdanks0RW/k4U77TIyvQGfR6nVbvTT7E03b/xtNJp2NzkNEecYxOXMzR/+3FrfpRA23kRkka/3q0ok7a9S5u57EdW/vaOkztZfKnpXJ5tVCtFg+XTfuiUise1EqVc9N27V8=",
            -- ["PvE"] = "",
        },
        [3] = { -- Ret
            ["PvP"] = "1|RZA9L0NhGIarbMSIuzHUj2CoSRjE00SRnPcYSTscGhppj0RCHCRsYusq4quVIjEQkVZE0mjqozV30Fj9Bs99OnS5znnzPh/3e+11bR/3ezvZ0VCgY3oTUoeUIK+QMqQIeYY8wRhIDVKFNCEfuGvAuFo+NQMzD+sH1i/kC/IN+YRZh7H18qZPcVsNBYITGcgDKlt6XrokThUbVf6dE3lF1FPkAXnUb8+wondEcdWp6H7hpDdF4RByz5YLRS5L/PGuwgk5HllaiHD9GNuPFNdxdpyx7l3TNCaJIrF7MnTQmuqHY2IN66/VxP5m3Rfcbydt5fMf0A4Z9cLZAaoxLl+vdlQZ3ZWoT90Z2/fUpCpKrFGiqlJnNFf3zZUp3ViePTi37CST4wupVCIeCc8m0mvOYibtrK6EY27sHw==",
            -- ["PvE"] = "",
        },
    },
    ["MAGE"] = {
        [1] = { -- Arcane
            ["PvP"] = "1|JdA9S0JhGMbxkwp9gbjpOhKePkAN2Qt64pC6h+HQUASmDpWEGTX0KmUR9gWk7dDaVELUGWpqaNG5pRKiWpuyILru4/J7nuGB577/1VDF7Z9xgwf1BGQUEockIVHICGQCkkL7BDKG5hMkhpYBsSGTkHGIA5lCewFmFc1l1Do4jaD2A/wC9AV4RXjNNHoWm6QxRGK3xI7ozSO5L/IcgplHa5rXeJ9yRpxecnyn3MPM8by8Jldbyrayo+wqe8q+cqH/DCtzyjy5eVc+lE+YDzwf30wjUP4j657yrXTIxgBpZM4HD/kjJ+fzwFF3MH/u7gaev4FVD+u2DME6msbxN/d3ZhRtl/RjRbUg87ERk7ERmzIZU7IRWzOWRrdZ0A3OZlaWisVUtlQq5ONWopzLrhas9Gb6Hw==",
            -- ["PvE"] = "",
        },
        [2] = { -- Fire
            ["PvP"] = "1|LdG9SsNQGMbxGpwc/HrF5EmXurh5A0qFpqb4QbFGnJwUC0kbba2gHUuxLrmB4uTHJSjqUBQFB526uLkoToKOnX2f1OWX5IQczvvP8WDj3PKavWbbRfcV4kLykFV8vkMWIIsQB90X+DZkGbICyUKWEJUha5AMJAfx7IThTMM8Q1RCFMJ8g3kBP2knBk7uYTl6ffiCNQTk9XbujlyRW1iufrv5jSjg8zW5UdKnyvazMv+hlCpkn/s9kifCt51hMkJGyRgZJxNkkpjEIiA20aMZNd3FOEgrRzNkl+yRH/Kr1LlW51q9cjnV6s8TD8F5HB3JaMXD/J+fk3UknizVttlBi2oTDRbH63fSuBq0X1CbaV/x4qwZRtfQfpL9WN9lTibW35Bv9jbWy0EYZreq1eLObCoX1IqpwmHhDw==",
            -- ["PvE"] = "",
        },
        [3] = { -- Frost
            ["PvP"] = "1|RdFPSwJBHMZxEy+ddlY89EjBduoa/YOSLAi8tiB0l4wlkpIsL0WphBfPgqeggg7VoXNtWalFR99AFApFrlbQC+j3uIGXD+wwszPznQNf5mggms2VIlBtqG/UB6GPQ5+A+oI+Bd2EvwzVgfqB7kN9CNovrFnoY9AX4T9GoB/KgbYL1YIVhjWHQiPo8U4XUWhC24G2Dy0jA7Fa0NM33xTWRwW7LIQc8k5awsszrGWZGgrIR+2Cwx/kkyvPhHyFVEmd/7gi18QmN+SW3JF78kC4zOYym4ewH8mTUBkRqpfc7Vz2Te0J24fklbwJ6Tg5Je2T4VzvDt78/y3c4/Zu4R7cMUpGt5nJDlJLsrGrj2mln2STVBJH6kpmCVloMKFyuq0Ymu8hbzDJiu7DqI5bVmprGfa3wtml6NpqIrEQSyZX4jNGZHMjtWWYafMP",
            -- ["PvE"] = "",
        },
    },
    ["PRIEST"] = {
        [1] = { -- Disc
            ["PvP"] = "1|TZC7SgNREIbjYnFYA2eNTf61WS28xztEBQVREKwCNraiKRaDWRAtrDRsonjFyrTiG2g0uj6AlW+wtppgZ5FW599tbD6Gw5yZfz6//fA2PVVqlapZpPrshLGQFaw27ETbyBHUI3RTyswEUhUkV6A/ob+Q7IJuQL1CBVAvUDWoJyQPoOpQz+ioy4SZd4HzI3+LNzCLsExOLBNnxBWsAemYtRBOc8EwH31Wg6wqxDFxQpwS58QFcUlcs7mfGCIyxCgxRowLvLRsmL8nHoiaYNG46yn/i2aZki7Ka0Tr/ChXnDSOEseNMjpVG/pbzo+VyOk8OkAY8GGSRkSQ6BBHnW+RvQatiTvdFC9imII+eulLZIV7CH9LrfXutW23UFja8Lz81pyz7O5uul7B3ck7uf3cHw==",
            -- ["PvE"] = "",
        },
        [2] = { -- Holy
            ["PvP"] = "1|NZDPKwRhGMfH/tBjdt89SK3vFg0tO63LJj+yGMVFucyGg6NwkC1bG+WGRC6OcmPsOogcnFwoKQcXf4A/wcVFOXq+r1w+87zTzPN+v5+DxG7UORTF988mYIKc03J9nnNiwT2nC53m8jBjMGVIK8wkMk2YUWSuYMYhSUga0obSI0pPcItwByApuD7EQFyIwIwg6+iu/CDxoyj0Ko4SCj9EdorPCjre0P6O+rSe+or88pXTCfGt6C8QS8QXVywQh8QD/+8iugm+W/ngBZ8sEBGXRINoKm62FLfDxIvi7rnRs6cRY8c2lUb4y2Sj2hR+5T+0TeaH3qmtl6IU1vbZXBWoFzWlmtg8TVmqhprE+groTgWpEUlG8cX5jfVqdWa5VltbLXuzm9UdL9wOfwE=",
            -- ["PvE"] = "",
        },
        [3] = { -- Shadow
            ["PvP"] = "1|PdE9S0JxFAZwvUiZStDWI1w6UUGDY283koggzTQtLdcEhV4knaqhIMNSiKaGHIqKqNvm4FBDH6AP0dgHaHGu89zQ5ce5F/7/e8/zVD2nj4OTlbNGEkcIuty1McWucsrAnIL0QvpgzsCchmnBnIB4YYYx4oMYMOcg/ZAeDP3iwYIEIG5sXevpuxNyjFAG4od4MJ7VF7sFXrzET9Q5rQVdRszPKU4i+hhtI/SJ/BUKC/rqZYDwQG2dRMkyiZEVkiCrJElSJE02yCa5Ie/K/a3y7CM2+eL1TfLNn2ICNq+y9Spj3sXpnFyQGvkgP8rrqNK0lJabcINWArk3PRneJ6Wn4YrubVx2t4zoYt2F4rpoJ4Rou7Oss6ddlwac7L2MnwkGNFeGrQ1oLRo/C9FaLCdsLY/Rsw+DmWsZWpJ4/ktwCqpk03s7xeJirlwu5GclvZ3Llw4ldZD6Aw==",
            -- ["PvE"] = "",
        },
    },
    ["EVOKER"] = {
        [1] = { -- Dev
            ["PvP"] = "1|RZG9S4JRFMZV5ATtRY80WHNNNfSpkLU0GS1NiZCFJCUkRltmGDSEVoRrFNjH4tBgpCBUfmWS/QHyUg39B62d581w+Z33Xs577nN/d9++e94Xj+2l5xwWa3gcxjPrGBJZ1kliWlHLOCw2dwpd3ZAGpMn9KbQWIG9o/UDKkArkBVJF6w5Sg9TZ0gvJQ3KQAhIzSOxA7iFFHfV9BnmElHC0rX2+HmJVsXZD3MK4ZL3ijFNF1QVjEIYV8qSr5XnuJ9mR4VeKOCZOFCWGKzN55YHI83837zBCjBIcXLsmeF59iBgmfMS74tUOw6P141PTfh1cDMT/Fxrd8NgOzUCdlElN18n/H63qMuM60w4Va+oqq8K2mZwpp2iaq1NkIttWpK5UpDRpVO3SaOHPP802TPnmM8WW+hfXg6GQxx8OB1YmnLOBqH8r4o8ENzec3qj3Fw==",
            -- ["PvE"] = "",
        },
        [2] = { -- Pres
            ["PvP"] = "1|VZC/S8NwEMXbXsCOCkV8BSXdHBztYBGrdHWI6CC2ta00kv5KYyKdRYqDiHPBQYKDi1sFFzv5NzTZnASnLq4B9e4bF5fHl7vvvXv3GWoX/tLQp8vRZjaRrLjZRKr4A7pGmAN1QR1Qm2vbBcytgnogG+SAXJAHbRGzZ8zGSK8jfAQ1QWtsksyAzkA+qAayELwjuAOZoFNQHdRAOs+/rKrIMbQW5u/lWWbp77HYIaINaLu8dqfI8jrhYlXaR98s5RcJmpHaJyiSqQOZmrIsfLHUT6QnSSolaTyJBGw06bB8vD3kbuI5KcZt9dHZ+rdMOShDe4roVhmnrlRyDh2H/0vOefXRiuIxVjf6AkOuthREWwFrMx5BxXCpFnNipsw5nReODEYImQqlo8j3FEiPEfp0uLzfaXW7pYbjmM2CbrimZ7qDxnmrb+vGwPgF",
            -- ["PvE"] = "",
        },
        [3] = { -- Aug
            ["PvP"] = "1|LZG9TgJREIWRmHkFHSIJdjYmWmpilPACJFjYKUbUjQhbIEpsDJHWevGPEB/AJ7DTwlhpIiC6KPIvQRtC7ZnZbb7dm5k798w5p+MnxclcdpS1VpjqPs9YtMNUZXpn+mCymWo+j3f1mOmT6ZupwdRk+pO+LlMLteV7abhl6jFVmPpsrzOhhjFtphJTGfXLWdzYWAB2jwQZrs3JN832I9NAfg+lwxBsC2JA8klwLbgSFARDwJwQRDA4+MP0xvSL8+ZIypYgLzhH+a4ItDxA91VQAr78QH0eaMwIngUvQDMkzUvAxcPN9JmOdEY7Qiz3ZWeb5BAvqwK94ArSZ13NeW9OF3Z3zTgL0yBgTamXbVWkfpXVcFjcV7ddeyuaAfzuqmxkgQDUck2m5xrf0eCwIQJBNmp6NTta80f2jHg8FDXN2NZiIHiwsx9LpKIpI5kIhNPhfw==",
            -- ["PvE"] = "",
        },
    },
    ["HUNTER"] = {
        [1] = { -- BM
            ["PvP"] = "1|TdA7S8NQGMbxWBz8CD6FU+MQcBRHQZRqBcFqrFbdNNoM1Q7FiiQh2gsWFBUXhU6Kty/QpYviB/E6ONuazILvYxVdfhAOJ+d9/7udpYvunnKlNhTVIv13cBtwL+HXo1rHmIKaR+DAL8hZ/ByeDmUipiFsQU1CJaFSUHNQadyfQc1ATSNsys39EYTvUAtQU/Cu4d3AaMH4gBHwt1lyLCQ+hfE+Yc0jRbJNfMGx5NWJAX46ZIeUeLBElskKWSUZ8ibsPZBH8kSeyQt55WTDwsGtcHgqHHXJGyeJq94qx/sbNYhUf8f4Hoiz/IxR1GvgolKCS6fYQxq4jXY/2VvqSDTZ/l83v86WLCbd0u1E0lmahU2pVF6Mza5nc7lRK5+3M4N63LYKm3pSsDdc3dwyvwA=",
            -- ["PvE"] = "",
        },
        [2] = { -- MM
            ["PvP"] = "1|RdA9S8NQGIbhGIQmgWQS2qdQiJvoPxAnq6MQcHEtWG1tlWhBCragaeNnxMGqXWvxc7ToaCk4WH+CCE4OzoXi6PuEistFOIeT8567OrzdiNle36tPx5WhmRbME2ReoDdgaOi9wczD0GGWYJZhRGB2oDfRe0Wvi2AcWgvaA9ol6Jcwokg8Q49C+4gr6nuSv3skT8LsFimRsrCyT3aITyrEg6XAGoE1Bcvhwh6pkl2hmCZL5JSckwtSJ1/CwRW5Jjfkltxxd5lf98LhunAUCMGEcMw7fuTp6tgngvCGGjmTlfZ3c7Tyd7hYk23VH8z5P144uW/XY2wk7x+0iEgFppF20lGisGOUEaWdxGXEbti3w9wau4fVpKrXX0jM57L5fDLluunFSXsutZErrKbWCpmsazubzi8=",
            -- ["PvE"] = "",
        },
        [3] = { -- Survival
            ["PvP"] = "1|RdE9S0JhFAdw0z5D9BdO6tBS+AUKytR82QQRKnCwcrArIUGXhqCIalCvFjS4SmMvEG29+RJt1Qdoa6nGUmju/K+Sy4/Lw3PuOc//7A/v1kd9dddeLeZ2OAPbMNropmC0YDQhIbdjaK2ozE9AZiDf6KTQ8cP4hATR3UHjCRKB5xoyB4lB4pAAJKoV6zXILCQMWYQsQdI8M7XHyoiyzG5vj/zzJPErkUvyzpZlckQqxILnB54OP6vkWNm6IbfkjtyTJmmRNvkgX0rxjJyTC8JOxSul9KuUs4oV5/sfWNHA+DSPn8kLeWXXEue2iI7nPCmf+g4Gt/olvYvOw//5rUFR/wUVb22M0Wh6ErDzsMML2qGG+smFmbJEmanugdtoa5B2hFyBBqpL6m1E89fYuYK0HazuxM627lpA0sjl86FMoZBdnfImNzfMnJnJexNm4g8=",
            -- ["PvE"] = "",
        },
    },
    ["WARLOCK"] = {
        [1] = { -- Affli
            ["PvP"] = "1|VdA9S8NQFMbxNmTyC7RPu0SH8w0cdBDEoRWXgougi7QNRKO2IOIoGmt1Uzt0cLAIDk5+AnFxKVpfS3URHaQI4qTcqcXnxA66/EIuN7nn/gN7rRafrtnr1aFExOrbg9xAmpBLSB1yDZODPEDuIQ3IFeQW8giTTUSibkfpouyjvABpQZ4wPgGTh3FhAv3bPql0IC+QZ26es0g6rsQgr3x+d3U5SlInujxC3ovkY0BJkc9V5YB8DRIzo5SUUz1iV6nolnPIG1+KnM06LClbSlnZVnbI2TFp14/6N/580q5bm//GCydKx8IBnWoyrMG7N34vzCoaiSXuwjDM0+xdtKV12IHVGIFZNEgAc9GrwWjai2lNlqVq9lRyct7z/bHZQiGfG3ZGXdf3ssve0qKTWcn8AA==",
            -- ["PvE"] = "",
        },
        [2] = { -- Demo
            ["PvP"] = "1|PZAxS0JRGIav16COYeWQ9FrDTWp1aQsjSovahJaCGjQl1Fs6BW4qBo41FEJDSUNbd8olcMhqKyqifkH0E24QVN97b7k855x7z3l5v6fWU26OrFeqjdmQph9OQaVkHcoKApewY1Al+Dzoe4A6hncA6gnqESoCXwtKhz2P+gXqFnqv4A/Lo8Uq9BP0v8OOw16APSffBvcZmcOkBq+C/hnSPEsvCN4jOCzbXJTnV+INxgYmnuV2pC3nZY0tWrwzw5g2Y/KEyR8sGtgk0tC/ZD29JjrEDXFL3BHfxI+gycimR9BJEsw4WhN8HJyN15xusnWb6nt/Hf7bddtEjcYYHdQtZ2JXnKiQmWVymV9ZlOMPUw51pVwBrj/R0jVqn4sicelYom7xqEqV1dGVfNY0Y8liMZOeNuKZ7cJOwSxslYzEbuIX",
            -- ["PvE"] = "",
        },
        [3] = { -- Destro
            ["PvP"] = "1|RdFPLwNBGMfx1TZt9NxDf43IStzdHYpweZwqHFyEotJW9X+r/pTNbmlfQFHCYSNxEO/EQSR64Q04uIldF+p5RsXlk92d2cnMdxo+ww4v2V6zMwsqRDRPcFlYgfMI2gaVQEVQBc4tqAzaAeVBdVAWVIM7DEqCDtDqgvZA+zBdOFZEG/Acge7QesJnGJQDGbyo+cG0A6AGyOQ56QlGPZEFaoIyPD74ANrCRlXGo6A06FgmHAqGfJxkvm6Y73emNyf0+EffPeOXE/htJjAqi00JMhocE+LCKqNpzKXMuwoJC0JbOBFOhTOhI5wLF8Kz8MK8hq5HLLWQ2iC/e5qyW7Vxsvqn49P8HTEd1Tu6qpiUMtIvp1oWVOCSqlsBVVX1miq924/KgbkrGXDfftPy3XBavgbHksB8Da3uf2Dbuzg0v5nKZKbj+XxifVyfSZTKxcpaOZXL6rFq7Ac=",
            -- ["PvE"] = "",
        },
    },
    ["DEMONHUNTER"] = {
        [1] = { -- Havoc
            ["PvP"] = "1|NZA7SwNREIXXTX6BIHhSraWoKS1sbbSRgGBaFyNh44JbSGC1Mb4QsVXWYudmSaFVWpNCC62NbfwBdoKNiC+iZy6x+YZ7YYbznYP8bjYeN/aS2YIz8rUEKerM0B5Fu4z0B+kApgazA8kj/YU4EBeSg/RgLmFCyA3kFvIAE8CcQAxMhzf8bZgu5+c0McjpT0xUfcUq8VHRv33ipUa8ThJvZcU98b6oOFU86pUrxbdubCEbQ/MJzX7BcTt3xPmx4ppIphT6TJ6Ji4jozrQmDu20i33u2jPukU1pIw4jx/9Rq753plb0p6QWYc1Vz1XhYSM91aawFLUdlsKyWBxLMUFjZXkjCMN5P4rWK3Pegl/fXPNK9dIf",
            -- ["PvE"] = "",
        },
        [2] = { -- Vengeance
            ["PvP"] = "1|NZAxL0NRFMfbp1JiweRfSy2m82KwGbqY1PJuxOtTqZfXenhRTS2adOK1KkKFrQuJPMEn8AGsjOVjiKmJhHDObS2/e+7JyT3/+2smDm+n6mEv7GRAq6AWaA2UA4UgB9QAuaAiyAatg/KpWPzbAt2DSqAmaANmVnoRqAB1BxVA7UC1oKJUzGh3YXZROwE9gjxpBKAHPl+uoZZRe4WZ5FviE+YIn9YNP+XluMpmGEOzDGOLEVuS6zMj/gVzlKd+6zLqcmf4Q+b3pTpiJJ8Yl++Mq3HBhGCScf4j++cZF2NSvTHOetFMQwLMcU691jjtpyOPY+s0nH0QzUju9dO3g3RnWmzxP0WVo53ltaGCOCF34KSoPZa0xyY7AR2LYlEUsDk29i+0b4vssOekVnaDcnnRq1b9zYW07Ve2fa9S8tPWgfUH",
            -- ["PvE"] = "",
        },
        [3] = { -- Devourer
            ["PvP"] = "1|a2FpWChRvZC5aYaxFANjQjGI6JRiYHK5A2J1gIh8EFEAIgqBhNIiEKsIRJSAiFLJgwwgulzyIKPkQWYQsx1E5AKJ5Fcg4g2IeAsi3gGJ3l0gYjeQ6OMDsfaCiH0g4gaIuAkiPoNkeUGEAIhwBrpn0moQsQokuwdk/EKQea9BsnEggh9ExIKIChBRCSSmyoIIEFdpFkjxS5C2PKApk01BxFSQeWtAxNrFis1oqpg6oHaA7UWyA2w52CKQ5UAHKUyEB1EhNCRKwcEBD80CqG3QkOsEhhM8fEvgYdkODbuOhcwRksHZmTk5zokFBakpVgouqWX5pUWpRQoBZQEA",
            -- ["PvE"] = "",
        },
    },
    ["ROGUE"] = {
        [1] = { -- Assa
            ["PvP"] = "1|NdFNSwJRFAZgM/sHCZ0JQoMWZUGbPkioTNchBNWykRImzYQJuROBKUopBIEglkKmVkK7vqNFriurH5K73BV03mtunrkzcz/OPW/CsnvaMxiL5xYVU4f6w2Q7gQV0gS8ynLTXT8YoGQ4SGcrYSaTxx0dCI2OSmt+UWiKRJ2OMRJbEAYlDEhFMaZCIk9ghESWRpOY4CZ0/+1+YvA88MZclUGYCLjALZpijX6ZUI8ND234eFqxUmcazm1I5Sj1i3gjWVsAZOAcXTNFBxjwmuJnjIYzmmPVrcIMi3nBCHbyDD/CJA5+ZlSCJDX6WFaaKRVUsqt5iowmM7sA9eAAoptTAvq94TYAkuMIuvcwJblNEJcVhxWSuD5TtcVkHF2reb9++VGtd0PC0GyBbUbDKzthyiuyiJrPQ/1OIIAXuMlKIyo4nEYpIt7PItNKRicickRPnyJkiWWdsuW8hoAWDbjUcXludsrl0XdV1LaRuaZshmzfi/QM=",
            -- ["PvE"] = "",
        },
        [2] = { -- Outlaw
            ["PvP"] = "1|PZG9S0JRGMbNGvIfqB4XbWgJvItb39IkFEqZLQVeKiF0cChNhwqpxe0eGoQasmsfN6eICvqCaA8agr6bgpZWG1x6n6u1/M499773nPd9fmstq6WO7nw1XwxD+d2OppM+wWkJKgQ1DZWAykJ1wbiHOoIK8OM2yibKX9AiMG5hfMD4hlGDckG1QxvFrg9aFNYWTxuA7wHaCJSJAxPaBKyg2+EsXMm3m4ogPgUthkozaweJIUFqhk+863xBkEgTiwS3Z8+Cywi0MVljn9j7gabjsBdmG3aesKOzcInIEFkiJ7BeiFfijXjnJf3IHfO4CVatEMtsrUzsEfvELiqbsl60sjTKNxZxKLh+5E8bMtSdx+xcb2xkuP+54lPOgrRndy5N1/u1W7fn+BurMaW36GGGymXHxEQZYIQBSqjKX89VHEioRq0ecV2RGBMRIk2MqAB1WUEKEofiSwSKMlFja8hXJ8cT88nksJ5Kzc32eEOLC0k94w2nw78=",
            -- ["PvE"] = "",
        },
        [3] = { -- Sub
            ["PvP"] = "1|VZA/SMNQEIdjK46W0jbNL00lTg7FWZFuTuIS6NJRxQ7WDEWroLeIKDVD2odTcAulmdxdVdD6p04iDh3cdHARFyfBuziIy/e4d4939/sORvdCoxQm94NZU0uMb5jayNIrqAAqovUNskBpUBYEHD+DTPTeEZXh6ThyQBlQDqSD8iADj1/YfYL3gd4JfAv+Avw3/q9+JbgW3ApuBH2czkDVQROIPLm4QGco56XgTnAvGAgeeLXUGCOjMXLTDP2MkV8UvDCMTaih9D7RLqFdhVJcDYLu5CFXvw2l+A23Ey2eLd+ex3P/7xWP79tBQdKIBksCdaYkE4fmTCyAw0XlWJc4Ei9FUcNGOL8YSXPy2E72zw4hTFZRWV9z3fnlRqO2OmdXtlaabq25Yzvbzg8=",
            -- ["PvE"] = "",
        },
    },
    ["DRUID"] = {
        [1] = { -- Balance
            ["PvP"] = "1|NZE9SEJRFMe9z5aG3JJzpOK1NGXtUQ2+qZCQStHR1CB6qYU1hwUN0sfQIG4Pp6g1hFZd+gLXrECpobEMK5o6//to+d17zj3363f2+3YdyjneYnmZ1XHAo57OWHlZEXUksM/pg9UhqyPqsjIk83glaJdYFajK87OspLzOqsG1U2rKUsJHFxSjOlX4rUYpSksu/ksZWsWiw5YeG7Qtw8Y0MIPEIGYxIAvkgDywiVdcC1ptzO6Ae+AWuEFJFAcMAcPAiGDlBXhFOAYEgUk85YetfmzaYquE+FvwPBfwGIvvCHvAF6on2IiystjwsTHAKkhhWkB+HPCj7JNDJxy6lL3NlqBYw+yhOronn9T/SzSMA30Uhf93xnv6FPcKv1k2qas1w6P4qriSVEHUUkeMU5Vgl9KU0vKlE9ImV6YPzkW2bojW7HZOGkJNMY7OOd44La2v2baVzOcz6SkzlLST2VTGjOxE/gA=",
            -- ["PvE"] = "",
        },
        [2] = { -- Feral
            ["PvP"] = "1|TZFLKERxFMZnpnOvYmGjy6fUjHfZWUnNylB2Ihp2ExJmalgISZrUGMqr8VipcaWU2HhsPJZWkpSFmY0oz4WVslDONzNk8+v7n/u/5zv/803LVKIoHPmMrHcVO5zWkiKUS7WiCGwrUp2QUbw+QsaxMaSFoAcyBpmFzOlpcA8yAYmqTA4o7mshM5h0QWKQBMSGbOH4gS2XFf5ryA0PcRheGDkqH+pgAEYNDPYrLIXphZkL41ZPfU5aPFEVUO3Sv5IoI8qJCn518Ou+4m6R6pl4Jd545YLqhaqa3ifEGXHOmlvRneKVdzTmw9fOYhV8HbzBv1JfxQ5XazPHTz+EjS02tk45sR/GBwwb5irMNRbmiQWCw4Q2CVtbHDoJHdV1sKM4ylNcXbLmV0S/bc/07+Pn9P2umHb9Mz1Vl4ybuZoeImNmvbnXS7KpTHCnun254dLTYSUHNIj/y09w0xqlzGbCYrBjmYA0CM0tnYkVz0Yb1ZSZvyYkduSzo22wPxhsCITDvT317qbe4UDQ3TLS8gM=",
            -- ["PvE"] = "",
        },
        [3] = { -- Guardian
            ["PvP"] = "1|TZG7SwNBEIeTI8HJJU0gxU2wOCEm/gMWprEQPOwCET3xwQVikQcSFU0nKoLgo08jEiy00s5SLExlpa1F3sYkdmpn4fw2CGm+2dm925355sizXzY2y97D0lzY5R75CLu02WdZOVkgJ6mBPaPL5jRiD191AbXqCygoB8kppirvZZmaTHWmBlOfqcf6GZOH9TjTOxcjrMeYWqyf8skk209sV+R/n8Ykb7i1X/YFmWp4eJ71jsTMo1x9t81+S2K0jZM1DjgcuJDcCrHfwdYCsAgsAcvACrCKKx4Eb2HUXgVqQB1oAE2gBbSBDiBNaaPXwI1g4lLwEhXc3wpev5COY/UN/FyNHaiKtWMpc1CRKtsKDdWsd8ySOegRLmrSMRSIGqoro3BCjSGbIk5siiPqK9usnyt1MaVdTQPm7Aosi1zxLvaKkf8pGp8ykLLX5mQuk8/PpAqF9XTctHZSW+lMasNM7Cb+AA==",
            -- ["PvE"] = "",
        },
        [4] = { -- Resto
            ["PvP"] = "1|RZC/S0JRGIY1HAra8zUHzz0FzRUWmWhIVlRmBdGooIEoKSbNElHo2OQq4hD9AS1NNVQQ9AuTCiqtOegvsO+912h57jn3fO853/fsO4pVZ77q2KvMumz2+ANxQVwRl8Qr8UI0iWfikbgj3okn4sZl61kd5OqTaBBt4gP6Hp1vnIbRqUHNQc1DLUAtQi3LeesAKgI1A+WHCkAFmXmD4YQKQ5dhFGEMwPDBcMEAD7+Ia0YP5c0xt2D8XDAZws+ZfL1JwYRXsGSHbmHkFkNt/j8RlOrQMehpWY4eQUcwnJabtja47ydWiAaHSQiavURfTZXNTLewIUGz1kxblVZaroz1mG0dW4+W6mZn/21Jj54KOJbMZ9kQM39C6EKXTZWmkwDNiTYDtCAi6cUvLrqWfF2Dwapj072eTmUyoXgul0xMedaSO4VsPl5IZbc90d3oLw==",
            -- ["PvE"] = "",
        },
    },
    ["MONK"] = {
        [1] = { -- Brewmaster
            ["PvP"] = "1|LdE5SwNBGMbxXJJ8A30iIRsUZtRCsLTUTpuAjUVAAgkYk2iIsraiYmMjNqYNtjYWfglvUJMY8WJSixDjmsPjfRab3+7COzPsf7YDG+WBdNm/WZqB+oJyoDowQZgQTAUmgZMDqC5UC6YK1YP6hPZAtWFqMDuw92GvwF6G7sJMQPtg52DnoX6gfsMeb/RNWDgTFvf4dkEuyRW5JjfkltyRGrkndfJAHskTeSavxIQ9vkiGLAnRU8FKkWNh6Ig4wnCFwy/Q8uG1YtAf0H3Q8hst6A50EKPvGIlAh6Cb0G2MjaMR4D790D15Fs6F8uxhbNedcedljGt77sImt2oEZKFv6/8s2d2xShZLSBspxJxVt2WH2SSVhGROh7EZvsuoklN9Szn2M3XeALsmGFuqS13td6PyPuystC775wfnsplcbjpZKKRTk9ZUMb2eT66upYtW3I7/AQ==",
            -- ["PvE"] = "",
        },
        [2] = { -- Mistweaver
            ["PvP"] = "1|a2FpWCiR1vStaYaRFANj4npJ/ZUgeiuI2AIiNoKIzSBiE4jYIKl/TFL/uKT+VUm9aZIGfpIG/pIGAZJ6dyX17knq3ZfUT5fUb5TUmyypN1XykISkXo+kXq+kXp+kXr+k3gRJvYlAMzY5AomMeUBiwzMgca8DxF0kxcCU9xrI2nxN8uBtkMgCIHHAVfLgPMkP6yQ/XAHyDl4DEocDgMS59UDl/hckDbOAnK3MIL1tQOLlpMWKLWBBpgBTsIyk3gOmdohumMEHXMH2AU0F26IwA+ZK/ZUIh4KcDvTDFJAPQf4MAHn4zSywP++DfXgP5HOgJ0FhkQ4KFL2JTd8ipIOzM3NynBMLClJTrBR8M4tLylMTy1KLFALKAgA=",
            -- ["PvE"] = "",
        },
        [3] = { -- Windwalker
            ["PvP"] = "1|a2FpWCiR3tg0w1Cy7K9k2TfJsu+SZT8ky35Klv2SLPstWTZNsuyPZNk/yXJGyXJ1yUMFkmWTpRgYE9dJlk2VLJshWTYLxFsjWTYbRK+WLJsDotdKljMBaTE1IHEvDEhkrAESN9+CuEBDeiXLNYFM0YcgmXVA4nopkLixHMTaBSLugrjOIMIFRLiBxEpArFOS5SAzb7gCiaQAICE0E0jc/SHFwFTwB0gUeS9WbEMWBqqSPLQKrAWolakJbu0ahRmSQP9CXY/s4z/gkID4mAnim7LJYO8Cw2IG1POzgD4GehYUXIcKIF4vVwd7uTFCOjg7MyfHObGgIDXFSiE8My+lPDEnO7VIIaAsAAA=",
            -- ["PvE"] = "",
        },
    },
    ["SHAMAN"] = {
        [1] = { -- Ele
            ["PvP"] = "1|VZLZSkJRFIadmq2rBn8hMAiEoJG1SS2CSLNoErooUAJJKcnCQrqOsqikjOrCW+m6V2iAQxf1DPUijfvfDdDNd/Y6bNZ/1vpOwbVT8UQrzt1yHOrSa7NbTsKlMfgGdQ51ATmAzEL2IQWoE6hTqCLUGWQcMgPZgzqCxKAOIXOQUUgUMgl1DJmAKkGmIRHIMGQE8WfEXyBhSBASgAxBQjpq9UYj4GHoO8t7jfy1RrAHyxk+u3nBTTyx9GOpnbc/+KaBp0+e7ISD4BSBKqKaqCFqiTr2vyXuWNYTjUQT0Uy0EK1EGxJsnl9gkSM2iS3ikd/R6bU5ul6RSLHoJfqIfmKAi2S6xXSL6RbTLWZa7GtxoIeVq46CaWOSdKJu5yh+D/g9txm55/9i/H9rc/+uLeDxlTspRm9Zm9P7pbyg9qq3bHZtHNBQmNooNUKdFBmlQi3sx5xWPmXsThuvBaN234g/Mj9BSYusOBe982uZbHYsmculUyFfJJteT2/kk1lfbDv2BQ==",
            -- ["PvE"] = "",
        },
        [2] = { -- Enh
            ["PvP"] = "1|PdJPSJNhHAdwmyIeMnAi+JUOC4JOvqJC4Ds23SuBB12TmXhdbrChziVidpNp4MHuXqVbh0DQLFf+a1Psjx7S6iBRltpusYMeuvT9Pm94+TzPnufl3e/9/b4zFVML9V3Z8+x8oqHsSiiMYBOCYYS+61eviKDoRaAE/zUElhGYhL9bxz2iGx0PESzB7kLbBdqX0LGM4AjsGjh+hB6jpQ7+RrQW0HwEKwnrAaxRND+CNQY7rhdExd2GMk9qWrtd8VXkSKqfOCtkZUFn3/jc80qdrYo8Woe0vtHdL3EiTsVrYS7WxYbYFG9FHrczWgtiW//Up92OdvfI6h5uhXXyTrwXH8SB7va1OxSfxRdxJEzLfohj8VOcid+q8qV4JVSRo4qcLaGKZq6S3H2y1knWX5CNv+RTjBxUiUVy6GULep6oDx9JgW/xPPvz9MYsP4glo7zOrd5T4lpbbW5NzZ65y06d/G+l2ynT41DObaVps5O/7KeZxK5v/qYZECdrpqWIcIAMgx3n8E0O3KAwBsyA24iopl30mqgoAcwEo8AQMRmMBXPErCg9YROIpAJkjZrUMWEKDPMTKGXPB65Hh1LDw52xTCYRt3130slYejAxkkiP+yITkX8=",
            -- ["PvE"] = "",
        },
        [3] = { -- Resto
            ["PvP"] = "1|VdHJL0NRGAVwmm4lxqaniic1R2lNMcZCEDshohKboouGaFM+2/cqbEwxJt1JY2lhRZRErLHyn4gprHznVSU2v3vvG3LvPWfDaaXdY2nnemrWk5d/n4b4dLw7VVoyML9gfkMaILWQapjvMD9gfkLqIPWQKkglxIAA5hvEC+sZUgEph3hgnkP8kEZIKcQFccP6gKX/FkKKIMWQEkgZJKRbBU64nx/rU5AZrnc8eY6LJlgRPu9HchPJB8i0roLDZISM8mULaSVB0kbaleg8Zx1KYgHJMBedpIt0kx5+NcdZL5KPHAfIILnmIbbINtkle2SfHJBDckSO8VLAfYqUyzvlqpBweVVMXpXrZiUTIDxo5la56Tur3sju/XtIh//JsZPLIndbpqER/d5/VNPIpiKhbFrBESPls7PXlmrsjA3WpS1p5Nrhv8hL7dRdLE1bYldeu7RK9qk1/pXM5uvt8rVDX65Pd9oZ8k4uRpeWhsLxeGSh15iIrKzGEuHVaGzZGF8b/wE=",
            -- ["PvE"] = "",
        },
    },
}

function SC:GetCooldownManagerProfileString(contentType, specIndex)
    specIndex = specIndex or GetSpecialization()

    local _, classToken = UnitClass("player")

    if not classToken or not specIndex then
        return nil
    end

    local classProfiles = cdmProfiles[classToken]
    if not classProfiles then
        return nil
    end

    local specProfiles = classProfiles[specIndex]
    if not specProfiles then
        return nil
    end

    local _, specName = GetSpecializationInfo(specIndex)

    if contentType == "PvP" then
        local profileName = "SkillCapped: " .. (specName or "Unknown") .. " PvP"
        return specProfiles["PvP"], profileName
    elseif contentType == "PvE" then
        local profileName = "SkillCapped: " .. (specName or "Unknown") .. " PvE"
        return specProfiles["PvE"], profileName
    end
end

StaticPopupDialogs["SC_CDM_FULL"] = {
    text = SC.Logo.."  \n\n|A:Ping_Marker_Icon_Warning:22:22|aCooldown Manager profiles are full|A:Ping_Marker_Icon_Warning:22:22|a\nWe could not install the Skill-Capped cooldown profile(s).\n\nPlease make room for the Cooldown Manager profiles.\nYou can manage profiles in the Cooldown Manager settings:\nOptions > Gameplay Enhancements > Advanced Cooldown Setings.\nSkillCapped profiles requires 1 free slot each spec of your class.\n\nYou can use the \"Set Profiles\" button in /sc settings to try again once you have made room.\n",
    button1 = "OK",
    OnAccept = function()
        --
    end,
    timeout = 0,
    whileDead = true,
    OnShow = function(self)
        self.ButtonContainer.Button1:Disable()
        local function UpdateButtonText(remainingTime)
            if remainingTime > 1 then
                self.ButtonContainer.Button1:SetText("Reading time left: "..remainingTime - 1 .. "")
                C_Timer.After(1, function() UpdateButtonText(remainingTime - 1) end)
            else
                self.ButtonContainer.Button1:SetText("OK")
                self.ButtonContainer.Button1:Enable()
            end
        end
        UpdateButtonText(8)
    end,
}

StaticPopupDialogs["SC_CDM_FULL_HAS_PROFILE"] = {
    text = SC.Logo.."\n\nYou already have the Skill-Capped\nCooldown Manager profile for: %s\n\nIf you want to make sure you have the\nmost up-to-date version(s) then:\n\n1) Open Cooldown Manager settings: Options > Gameplay Enhancements > Advanced Cooldown Setings and delete the old one(s).\n2) Click \"Set Profiles\" in the Skill-Capped settings.\n",
    button1 = "OK",
    OnAccept = function()
    end,
    timeout = 0,
    whileDead = true,
    OnShow = function(self)
        self.ButtonContainer.Button1:Disable()
        local function UpdateButtonText(remainingTime)
            if remainingTime > 1 then
                self.ButtonContainer.Button1:SetText(remainingTime - 1 .. "...")
                C_Timer.After(1, function() UpdateButtonText(remainingTime - 1) end)
            else
                self.ButtonContainer.Button1:SetText("OK")
                self.ButtonContainer.Button1:Enable()
            end
        end
        UpdateButtonText(8)
    end,
}

local cdmInitialized = false

local function InitializeCooldownManagerSettings()
    if cdmInitialized then return true end
    cdmInitialized = true

    -- Ensure CooldownViewerSettings is loaded
    if not CooldownViewerSettings then
        return false
    end

    C_CVar.SetCVar("cooldownViewerEnabled", "1")

    return true
end

function SC:HasOneFreeCDMSlot()
    if not InitializeCooldownManagerSettings() then
        return false
    end

    local layoutManager = CooldownViewerSettings:GetLayoutManager()
    if not layoutManager then
        return false
    end

    -- Check if at max layouts (5 for character-specific)
    local hasSlot = not layoutManager:AreLayoutsFullyMaxed()
    return hasSlot
end

function SC:FindCDMLayoutByNameAllSpecs(layoutName)
    if not InitializeCooldownManagerSettings() then
        return nil
    end

    local layoutManager = CooldownViewerSettings:GetLayoutManager()
    if not layoutManager then
        return nil
    end

    -- Pass nil specTag to search all layouts regardless of spec
    return layoutManager:GetLayoutByName(layoutName)
end

function SC:GetCDMLayoutByName(layoutName)
    if not InitializeCooldownManagerSettings() then
        return nil
    end

    local layoutManager = CooldownViewerSettings:GetLayoutManager()
    if not layoutManager then
        return nil
    end

    -- Get current spec tag to search for matching layouts
    local specTag = layoutManager:GetCurrentSpecTag()
    local layout = layoutManager:GetLayoutByName(layoutName, specTag)
    return layout
end

function SC:DeleteCDMLayoutByName(layoutName)
    if not InitializeCooldownManagerSettings() then
        return false
    end

    local layoutManager = CooldownViewerSettings:GetLayoutManager()
    if not layoutManager then
        return false
    end

    local layout = self:GetCDMLayoutByName(layoutName)
    if layout then
        local layoutID = CooldownManagerLayout_GetID(layout)
        layoutManager:RemoveLayout(layoutID)
        return true
    end

    return false
end

function SC:ImportCooldownManagerProfile(profileString, profileName, makeActive)
    if not InitializeCooldownManagerSettings() then
        return false
    end

    local layoutManager = CooldownViewerSettings:GetLayoutManager()
    if not layoutManager then
        return false
    end

    -- Delete existing profile with the same name (across all specs) so we can replace it
    local existingLayout = self:FindCDMLayoutByNameAllSpecs(profileName)
    if existingLayout then
        local existingID = CooldownManagerLayout_GetID(existingLayout)
        layoutManager:RemoveLayout(existingID)
    end

    -- Check if at max layouts
    local isMaxed = layoutManager:AreLayoutsFullyMaxed()
    if isMaxed then
        return false, "MAX_LAYOUTS"
    end

    -- Create layouts from the import string
    local layoutIDs = layoutManager:CreateLayoutsFromSerializedData(profileString)

    if not layoutIDs or #layoutIDs == 0 then
        return false, "INVALID_DATA"
    end

    -- Get the first imported layout
    local layout = layoutManager:GetLayout(layoutIDs[1])

    if not layout then
        return false, "IMPORT_FAILED"
    end

    -- Set the profile name
    CooldownManagerLayout_SetName(layout, profileName)

    -- Activate if requested
    if makeActive then
        layoutManager:SetActiveLayout(layout)
    end

    -- Save the changes
    --layoutManager:SaveLayouts()

    return true, "SUCCESS"
end

function SC:ForceImportCooldownManagerProfiles(contentType, role, force)
    if not InitializeCooldownManagerSettings() then
        return
    end

    local activeLayoutName = self:GetActiveCDMLayout()
    if not SkillCappedBackupDB.addonBackupTimes["CooldownManager"] then
        SkillCappedBackupDB["CooldownManager"] = activeLayoutName
        SkillCappedBackupDB.addonBackupTimes["CooldownManager"] = SC:GetDateAndTime()
    end
    if not SkillCappedBackupDB["CooldownManager" .. contentType] then
        SkillCappedBackupDB["CooldownManager" .. contentType] = true
        SkillCappedBackupDB.addonBackupTimes["CooldownManager" .. contentType] = SC:GetDateAndTime()
    end

    -- Track execution state to avoid duplicate runs
    if self.processedCooldownManager then
        return
    end

    -- Check if both checkboxes are enabled
    local pvpEnabled = SC:CDMCheckboxEnabled("PvP")
    local pveEnabled = SC:CDMCheckboxEnabled("PvE")

    local layoutManager = CooldownViewerSettings:GetLayoutManager()

    -- Check for existing profiles (check current spec)
    local _, currentPvPName = SC:GetCooldownManagerProfileString("PvP")
    local _, currentPvEName = SC:GetCooldownManagerProfileString("PvE")
    local pvpLayoutExists = currentPvPName and self:GetCDMLayoutByName(currentPvPName) ~= nil or false
    local pveLayoutExists = currentPvEName and self:GetCDMLayoutByName(currentPvEName) ~= nil or false

    -- Calculate required free slots
    local requiredSlots = 0
    if pvpEnabled or pveEnabled then
        requiredSlots = 1
    end
    if pveEnabled and pvpEnabled then
        requiredSlots = 2
    end

    -- If layouts are maxed, try to free slots by deleting existing SC profiles we'd be replacing
    if layoutManager:AreLayoutsFullyMaxed() then
        local freedSlots = 0
        local numSpecs = GetNumSpecializations()

        -- Delete existing SC profiles that match the names we'd import
        for i = 1, numSpecs do
            if pvpEnabled or force == "PvP" then
                local _, pvpName = SC:GetCooldownManagerProfileString("PvP", i)
                if pvpName then
                    local existing = self:FindCDMLayoutByNameAllSpecs(pvpName)
                    if existing then
                        layoutManager:RemoveLayout(CooldownManagerLayout_GetID(existing))
                        freedSlots = freedSlots + 1
                    end
                end
            end
            if pveEnabled or force == "PvE" then
                local _, pveName = SC:GetCooldownManagerProfileString("PvE", i)
                if pveName then
                    local existing = self:FindCDMLayoutByNameAllSpecs(pveName)
                    if existing then
                        layoutManager:RemoveLayout(CooldownManagerLayout_GetID(existing))
                        freedSlots = freedSlots + 1
                    end
                end
            end
        end

        -- If we couldn't free any slots, we truly can't import
        if freedSlots == 0 then
            SkillCappedDB.cdmIsFull = true
            return
        end
    end

    -- Import PvP profiles for all specs
    if pvpEnabled or force == "PvP" then
        local numSpecs = GetNumSpecializations()
        for i = 1, numSpecs do
            local profileString, profileName = SC:GetCooldownManagerProfileString("PvP", i)
            if profileString and profileString ~= "" and profileName then
                local success, error = self:ImportCooldownManagerProfile(profileString, profileName, false)
                if not success then
                    -- Handle error
                end
            end
        end
    end

    -- Import PvE profiles for all specs
    if pveEnabled or force == "PvE" then
        local numSpecs = GetNumSpecializations()
        for i = 1, numSpecs do
            local profileString, profileName = SC:GetCooldownManagerProfileString("PvE", i)
            if profileString and profileString ~= "" and profileName then
                local success, error = self:ImportCooldownManagerProfile(profileString, profileName, false)
                if not success then
                    -- Handle error
                end
            end
        end
    end

    -- Set active profile based on main content (current spec)
    if SkillCappedDB.mainContent == "PvP" then
        local _, profileName = SC:GetCooldownManagerProfileString("PvP")
        self:SetActiveCDMLayout(profileName)
    elseif SkillCappedDB.mainContent == "PvE" then
        local _, profileName = SC:GetCooldownManagerProfileString("PvE")
        self:SetActiveCDMLayout(profileName)
    end

    layoutManager:SaveLayouts()

    -- Mark as processed to avoid reprocessing
    self.processedCooldownManager = true
end

function SC:SetActiveCDMLayout(layoutName)
    if not InitializeCooldownManagerSettings() then
        return
    end

    local layout = self:GetCDMLayoutByName(layoutName)
    if layout then
        local layoutManager = CooldownViewerSettings:GetLayoutManager()
        layoutManager:SetActiveLayout(layout)
        --layoutManager:SaveLayouts()
    end
end

function SC:GetActiveCDMLayout()
    if not InitializeCooldownManagerSettings() then
        return nil
    end

    local layoutManager = CooldownViewerSettings:GetLayoutManager()
    local activeLayout = layoutManager:GetActiveLayout(Enum.CDMLayoutMode.AccessOnly)
    if activeLayout then
        local name = CooldownManagerLayout_GetName(activeLayout)
        return name
    end
    return nil
end

function SC:SetCDMToSkillCappedOrAddIfMissing(contentType, role)
    if not InitializeCooldownManagerSettings() then
        return
    end

    local profileString, profileName = SC:GetCooldownManagerProfileString(contentType)
    local layoutExists = self:GetCDMLayoutByName(profileName) ~= nil

    if SkillCappedDB.mainContent == nil then
        SkillCappedDB.mainContent = "PvP"
        SkillCappedDB.characters[SC:GetPlayerNameAndRealm()] = SkillCappedDB.mainContent
        SkillCappedDB.secondaryContent = "PvE"
    end

    local layoutManager = CooldownViewerSettings:GetLayoutManager()

    -- If fixCDM is set, force delete all existing SC profiles for this content type and re-import fresh
    if SC.fixCDM then
        local numSpecs = GetNumSpecializations()

        -- Delete existing SkillCapped profiles for all specs of this content type
        for i = 1, numSpecs do
            local _, scName = SC:GetCooldownManagerProfileString(contentType, i)
            if scName then
                local existing = self:FindCDMLayoutByNameAllSpecs(scName)
                if existing then
                    layoutManager:RemoveLayout(CooldownManagerLayout_GetID(existing))
                end
            end
        end

        -- Check if layout limit is reached after cleanup
        local isMaxed = layoutManager:AreLayoutsFullyMaxed()
        if isMaxed then
            SkillCappedDB.cdmIsFull = true
            return
        end

        -- Re-import profiles for all specs of this content type
        for i = 1, numSpecs do
            local ps, pn = SC:GetCooldownManagerProfileString(contentType, i)
            if ps and ps ~= "" and pn then
                local success, err = self:ImportCooldownManagerProfile(ps, pn, false)
            end
        end

        -- Set the current spec's profile as active
        if contentType == SkillCappedDB.mainContent then
            SC:SetActiveCDMLayout(profileName)
        end

        layoutManager:SaveLayouts()
        return
    end

    -- If layout exists, set it as active
    if layoutExists then
        if contentType == SkillCappedDB.mainContent then
            SC:SetActiveCDMLayout(profileName)
        end
        layoutManager:SaveLayouts()
    else
        -- Check if layout limit is reached
        local isMaxed = layoutManager:AreLayoutsFullyMaxed()
        if isMaxed then
            SkillCappedDB.cdmIsFull = true
            return
        end

        -- Import profiles for all specs of this content type
        local numSpecs = GetNumSpecializations()
        for i = 1, numSpecs do
            local ps, pn = SC:GetCooldownManagerProfileString(contentType, i)
            if ps and ps ~= "" and pn then
                local success, err = self:ImportCooldownManagerProfile(ps, pn, false)
            end
        end

        -- Set the current spec's profile as active
        if contentType == SkillCappedDB.mainContent then
            SC:SetActiveCDMLayout(profileName)
        end

        layoutManager:SaveLayouts()
    end
end

function SC:SetCDMProfileToBackup()
    if not InitializeCooldownManagerSettings() then
        return
    end

    local layoutManager = CooldownViewerSettings:GetLayoutManager()
    local targetLayoutName = SkillCappedBackupDB["CooldownManager"]

    if not targetLayoutName then
        return
    end

    -- Delete all SkillCapped profiles for all specs
    local numSpecs = GetNumSpecializations()
    for i = 1, numSpecs do
        local _, pvpName = SC:GetCooldownManagerProfileString("PvP", i)
        local _, pveName = SC:GetCooldownManagerProfileString("PvE", i)
        if pvpName then self:DeleteCDMLayoutByName(pvpName) end
        if pveName then self:DeleteCDMLayoutByName(pveName) end
    end

    -- Set the backup profile as active if it exists
    if targetLayoutName then
        SC:SetActiveCDMLayout(targetLayoutName)
    end
end
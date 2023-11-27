# Contributors Guide

## How to contribute

### Requirements

- Go
- Git
- \> 100 GiB RAM
- Good connectivity, ideally gigabit internet (to upload and download files fast to s3)
- The more cores the better (shorter contribution time)
- \> 200 GiB storage

### Details

Each contributor will receive a `contribution.env` file from the trusted setup coordinator which will contained all the presigned URLs and necessary metadata to run the contribution script. The contribution script will download `semaphore-mtb-setup`, download all the right files from AWS S3 storage using presigned urls, perform a phase 2 contribution for each circuit and lastly upload the files back to S3 once it's done.

> ![NOTE]
> Please install Go in order to perform the contribution. ([link](https://go.dev/doc/install))

In order to contribute, the given participant will receive a `contribution.env` file from the coordinator of the ceremony. After that all that is needed to run is:

```bash
chmod +x contribute.sh
./contribute.sh
```

## List of contributors

### Batch size 10 SMTB circuit

1. [**dcbuilder.eth**](https://twitter.com/DCbuild3r)

- contribution hash: `b0b44102bf1201e83bffb1cb0c492cfb93421656c4d2d113840bb904a48936c5`
- generated file: `b10t30c01.ph2`

2. [**reldev**](http://twitter.com/reldev)

- contribution hash: `ed4570a3668448102b8f0fa2c47cdd592281a7dd30e568f112ec784b5f1d96e2`
- generated file: `b10t30c02.ph2`

3. [**remco**](https://twitter.com/recmo)

- contribution hash: `1a0925e14d4c3035d8ee5d288e376e723299b712181b4e34b59a337ebe08761a`
- generated file: `b10t30c03.ph2`

4. [**worldbridger**](https://twitter.com/shumochu)

- contribution hash: `c3092354da6c45b43a81e410364972d635ee563d46c24db77e1dc171f440a9ca`
- generated file: `b10t30c04.ph2`

5. [**kobigurk**](https://twitter.com/kobigurk)

- contribution hash: `d4e581570bbe53ffa9e08cc93816f48486cfd756df50894de74ac1845ae07feb`
- generated file: `b10t30c05.ph2`

6. [**kustosz**](https://twitter.com/mmkostrzewa)

- contribution hash: `7f13b7d526ec05775c9646908da8d99a35f48777fa341f8c25adf099135bb162`
- generated file: `b10t30c06.ph2`

7. [**m1guelpf**](https://twitter.com/m1guelpf)

- contribution hash: `e4ce787995a6c97b8be12f418ae3c026e26f84ad3d433e3fe6f33d3449d08c91`
- generated file: `b10t30c07.ph2`

8. [**atris**](https://twitter.com/atris_eth)

- contribution hash: `807552014597a0c51e4e0f2e9b989be7633d8a050906a894cab226bc2a85333d`
- generated file: `b10t30c08.ph2`

9. [**zellic**](https://twitter.com/zellic_io)

- contribution hash: `e0e690b8acf0dfd8bed0c65c55c1507fd261ac5eb86ef7f111d04b9a35b81587`
- generated file: `b10t30c09.ph2`

10. [**eddylazzarin**](https://twitter.com/eddylazzarin)

- contribution hash: `43c7cb5dd53447967cfe531ac2120948efd90fa5c80eb3b80fb340df452d7e18`
- generated file: `b10t30c10.ph2`

11. [**emilianobonassi**](https://twitter.com/emilianobonassi)

- contribution hash: `d60c8e2b3ceb98c6807f9e541eb163a011cca54ff9d859c5147503e47dcdbc8b`
- generated file: `b10t30c11.ph2`

12. [**leo21.sismo.eth**](http://twitter.com/leo21_eth)

- contribution hash: `6ae61f6ba229efdd93b7b98e80b5ecf2424038f1fa34e1d941b4ebab15a8d6d8`
- generated file: `b10t30c12.ph2`

13. [**yisun**](https://twitter.com/theyisun)

- contribution hash: `322bd95fe69c2b82e7ecbed4eeed3144869c3ae4a151bb39259d7ead1777d44b`
- generated file: `b10t30c13.ph2`

14. [**dzejkop**](https://github.com/dzejkop)

- contribution hash: `2b85850b40ce8659c932e3e829dc21baf79ea8e2c207f40a3bb0257f3e5cb7de`
- generated file: `b10t30c14.ph2`

### Batch size 100 SMTB circuit

1. [**dcbuilder.eth**](https://twitter.com/DCbuild3r)

- contribution hash: `66e1845efd543078218a92fd575478bd2f71d64b16a3bf427f5032dcc479a808`
- generated file: `b100t30c01.ph2`

2. [**reldev**](http://twitter.com/reldev)

- contribution hash: `b136004f834e6a4db35a5def1050d2aed0b4d41df57cbeb4577eb5c5997f9995`
- generated file: `b10t30c02.ph2`

3. [**remco**](https://twitter.com/recmo)

- contribution hash: `be313375479fa2ce7097129bb187f16df3211dba4e395acdd84e946fb4ae1e4b`
- generated file: `b100t30c03.ph2`

4. [**worldbridger**](https://twitter.com/shumochu)

- contribution hash: `30fac7bc6ff5f2bc24991dd5e6537e203714459c1e6d31c241d512490e966dde`
- generated file: `b100t30c04.ph2`

5. [**kobigurk**](https://twitter.com/kobigurk)

- contribution hash: `e53e7eae98d270b44e25ac8b413e1dcf45a13062c51cb45e6faad089a25d8511`
- generated file: `b100t30c05.ph2`

6. [**kustosz**](https://twitter.com/mmkostrzewa)

- contribution hash: `c202ab3e6a3e29041b1e3781cb1ffdbae7683541d32a91d8d92454b2ce0508c2`
- generated file: `b100t30c06.ph2`

7. [**m1guelpf**](https://twitter.com/m1guelpf)

- contribution hash: `10b5376bfbe4e6235a8b7f9b000699063ee8c5c9626e98dc70ed594f5c2e0326`
- generated file: `b100t30c07.ph2`

8. [**atris**](https://twitter.com/atris_eth)

- contribution hash: `e2b20b3379496da808a502df477b47846e7c6375a40e84e81730cf5d15142e44`
- generated file: `b100t30c08.ph2`

9. [**zellic**](https://twitter.com/zellic_io)

- contribution hash: `6ac522c33145afcbcd05291834f13b0b83833578ca1a13e4ef91a33a187f23e2`
- generated file: `b100t30c09.ph2`

10. [**eddylazzarin**](https://twitter.com/eddylazzarin)

- contribution hash: `3a4112517f6b9082c6d8faf1091164bcd4f818aeb7e53cb8ec2f5aa1eabdd05d`
- generated file: `b100t30c10.ph2`

11. [**emilianobonassi**](https://twitter.com/emilianobonassi)

- contribution hash: `8840c48bf70b565fc978cc893f42d8bd597b6904b4d1cd4b48048a39abda6e32`
- generated file: `b100t30c11.ph2`

12. [**yisun**](https://twitter.com/theyisun)

- contribution hash: `491a46c5aca878bd44f2d7d3b940128127eb705cabc6cedb48de74b12a85bf87`
- generated file: `b100t30c12.ph2`

13. [**leo21.sismo.eth**](http://twitter.com/leo21_eth)

- contribution hash: `7b13d503f70b5a1c899a5390c51e46d0a2194c1b0d97427ff2f6b074ee2263eb`
- generated file: `b1000t30c13.ph2`

14. [**dzejkop**](https://github.com/dzejkop)

- contribution hash: `f77f2e1cf197b09084c5b16ae0d2a61306ccf4cc01cfa9bab90d2b72ef071a24`
- generated file: `b100t30c14.ph2`

### Batch size 1000 SMTB circuit

1. [**dcbuilder.eth**](https://twitter.com/DCbuild3r)

- contribution hash: `6a1d0b08bf79fe564cd701e9af70bb5f3936f668869f529e83d8ecb1a3d474b3`
- generated file: `b1000t30c01.ph2`

2. [**reldev**](http://twitter.com/reldev)

- contribution hash: `d263eafd25ba809748390850966fd689379311033de6d4fc2de69acebb247d2b`
- generated file: `b10t30c02.ph2`

3. [**remco**](https://twitter.com/recmo)

- contribution hash: `1b5bb5f54d1126398b723ae4f42f86d9659550d57af262e67b9f8a6ddc7d926e`
- generated file: `b1000t30c03.ph2`

4. [**worldbridger**](https://twitter.com/shumochu)

- contribution hash: `9155ac2cc06510ffb63ac9a8c01284bf533183542054a94d735d358cc42cdca4`
- generated file: `b1000t30c04.ph2`

5. [**kobigurk**](https://twitter.com/kobigurk)

- contribution hash: `463c17a0c8ed79c56f4579d1eef02beac8edc91549fc9abae51c08e76b8bb4e9`
- generated file: `b1000t30c05.ph2`

6. [**kustosz**](https://twitter.com/mmkostrzewa)

- contribution hash: `dc8992e6d8bf5f9ed4b0cf9e98f582c0594d5775f315446c7ed1e94d3020e787`
- generated file: `b10t30c06.ph2`

7. [**m1guelpf**](https://twitter.com/m1guelpf)

- contribution hash: `1c512817cc55404489dc0184d7d049e6906f8282c542c17d9817a2bdab8ab524`
- generated file: `b1000t30c07.ph2`

8. [**atris**](https://twitter.com/atris_eth)

- contribution hash: `606a17d757c56171416c81dcd79171369e6ff651020d0dba0d7c98fa31ce78ca`
- generated file: `b1000t30c08.ph2`

9. [**zellic**](https://twitter.com/zellic_io)

- contribution hash: `dca70be8175332c8f3afe78018eecb5c205fef05fc0f177577dfed3bdb562304`
- generated file: `b1000t30c09.ph2`

10. [**eddylazzarin**](https://twitter.com/eddylazzarin)

- contribution hash: `34e92e61360b5e36d44736a8b2b6687c7557985e0acccd770b63de1b710c4506`
- generated file: `b1000t30c10.ph2`

11. [**emilianobonassi**](https://twitter.com/emilianobonassi)

- contribution hash: `40cecbd461f4cbb275c0a72c182f4481cfcedb5c0b72026ad84b0a007232cbf4`
- generated file: `b1000t30c11.ph2`

12. [**leo21.sismo.eth**](http://twitter.com/leo21_eth)

- contribution hash: `4c29e019d35c233c1e0f11953293dd42f567ab3d1949afdc4831f8b5c3179c38`
- generated file: `b1000t30c12.ph2`

13. [**yisun**](https://twitter.com/theyisun)

- contribution hash: `7dd5975f1eabee3b51b3e9d2890d558290c55f7cef502cc1fd66fb4e61cc4431`
- generated file: `b1000t30c13.ph2`

14. [**dzejkop**](https://github.com/dzejkop)

- contribution hash: `ba4fc054df53635a5efc9aac72e9de45a910adebd7da4f67aecd76e22e6ae9cc`
- generated file: `b1000t30c14.ph2`

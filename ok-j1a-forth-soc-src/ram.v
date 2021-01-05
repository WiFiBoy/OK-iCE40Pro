
    wire [15:0] insn0, insn1;
    wire [15:0] insn;

  SB_RAM2048x2 #(
    .INIT_0(256'h5356015230338cc6368bacb940c931dac00aa3698e67bf9b3576526ae5064485),
    .INIT_1(256'hf1aa2c5c53b9e5ceacd80659461523ec4549a45e0c9bcf465cb40db5727fa60d),
    .INIT_2(256'ha060289af74c36ac8b3f861e0861017c48d18c8084dcadf1ec60045433615f76),
    .INIT_3(256'h0d1693131bf382e5c41e11a1cea6cbc237966beac3e644fcaddc2f9e96bac13b),
    .INIT_4(256'h6cd8cce42b9f3ad532fa8eb5fbada904810480bd948202786b9301df8d313157),
    .INIT_5(256'h5ce6c5d79931b47c02b0653c7c8b1846307fcbfd21dab3dc3557c8be64e9ae88),
    .INIT_6(256'h64590fd3d978c3d69153505e92ca54dc992ce1abc8c184c470e675554a2528f7),
    .INIT_7(256'hb41d296c79bc1870e26f284c4c3d2ac88475bc4a2d60aef2c4dabac0087e817f),
    .INIT_8(256'h0052441a2646793c2242081d244f4c2b37762574216c7c366c3d1248352d0460),
    .INIT_9(256'h8099a24ef81a014f255008654f1185ef1c44245f421c00ddb8e69c5956066a29),
    .INIT_A(256'h48108555a4bc9114882080a095382d3c21347074e0c43555b3700ad9d32529e7),
    .INIT_B(256'h84704511a0fdc0b1b82c1058307d118c656d4010c0951190e064e5ddc07c4189),
    .INIT_C(256'hf080f35490083c3f30fcbd8bc19b0913e39ea414c6de8c573dc072e6ebc4f694),
    .INIT_D(256'hb3cbfe64e41d04f62c9bb018c945744de64ec272e41b022c735fd20c9a02519c),
    .INIT_E(256'h4a675c592e3290601a9604be38448a0f10b73469366e02cabca69aacf3e5af77),
    .INIT_F(256'hc80ba13edd61530ab02f995d9647d226586556def325b51811a41071d55ebc16)
  ) _bn00 (
    .RDATA(insn0[1:0]),
    .RADDR(code_addr[10:0]),
    .RCLK(clk), .RCLKE(1'b1), .RE(1'b1),
    .WCLK(clk), .WCLKE(unlocked), .WE(mem_wr & !mem_addr[12]),
    .WADDR(mem_addr[11:1]),
    .MASK(16'h0000), .WDATA(dout[1:0]));

  SB_RAM2048x2 #(
    .INIT_0(256'hb0b0818588ad462ca0bdac2836e752136a5b73a7889e954e38fe0e82156f79f1),
    .INIT_1(256'h805c108c653b1c0889a994216c1f72b35555901045a91804a96b073fca4a8129),
    .INIT_2(256'hc8ead1d10050a0a033ab42b2c0e890f1c868b0a80999243c195df1b1bab8a189),
    .INIT_3(256'ha2bb75f1c4ac8cee21f591b19682051dc2c252101ba23aae6bfd809221904535),
    .INIT_4(256'h92c6046c78d0024a161f65f608d8520ba1c119e95c180afadbd3a4d613a506b6),
    .INIT_5(256'h3026e0e485d380741e5c5450c0fad6cd614a8a9ce0d18b9f89c7fbd134f2c8c8),
    .INIT_6(256'h48876c3464f5aefd0a48529c8080a8fa207047d5a8f3d0b359da5b398f049a90),
    .INIT_7(256'h2041693008a85c94fffcc12032f456176b59f61115ca4f3b3c326a3c641c66b5),
    .INIT_8(256'h6f3f143c450554544b18150c571445434b0a0c0e7838154f013070306238ecb0),
    .INIT_9(256'h14365232acac6a38dddae222a4be432561f2e98a7edb64a01e1165b641121e1e),
    .INIT_A(256'h3dac0c8d9494288c84140160a4080025301464e5a9fc7c8cb637ebaa88344097),
    .INIT_B(256'h1c9c0804709c4c6925ec01216131645ca8bcacb470d4d5d479b980b980bd9414),
    .INIT_C(256'h40492971e9ebc9d3e29a00cde9491070f83a59f37aba24afccfeea6ba2c3016f),
    .INIT_D(256'h212390018ac9d1e745d360d2816a22738891637bbd30c4e818393c36aef78a18),
    .INIT_E(256'hf98b72de408286c7d0d984c5fb03111597f64404082c5c1b7ccd43426189d8f8),
    .INIT_F(256'h677e4d585c110d1c9cdc1454a061044e81117a7cd4fc46615b123c54b89e4c4f)
  ) _bn01 (
    .RDATA(insn0[3:2]),
    .RADDR(code_addr[10:0]),
    .RCLK(clk), .RCLKE(1'b1), .RE(1'b1),
    .WCLK(clk), .WCLKE(unlocked), .WE(mem_wr & !mem_addr[12]),
    .WADDR(mem_addr[11:1]),
    .MASK(16'h0000), .WDATA(dout[3:2]));

  SB_RAM2048x2 #(
    .INIT_0(256'h143028f2a022020051d48904e33ad05e90d2161cc6c0cf504a00ce00b0310202),
    .INIT_1(256'h9444fdf7d226a4aaa9600548e61841cc2c64307a8b05a0108467ac3848444526),
    .INIT_2(256'ha248e335d088c24b0820223b2848001cd9089c4c89613454c18d787016c4f109),
    .INIT_3(256'h090bf0087999421eb51e10a0122785851a8223829b3614a8bd2106c6843d80bc),
    .INIT_4(256'h7096c8890a9b7ab95f85c928ed65b4a6e5479d0d10c98a08b238ac1415063eea),
    .INIT_5(256'h1eb14670d96d764810bda33c18a7135fb158915718e6682c06183a3e64b1f033),
    .INIT_6(256'h03bac874b802b93452065a00c805188058ecbf538302ba125114620200bd5a97),
    .INIT_7(256'h7840d1e860c6605c418d61c496ba53f56b1ad2f69a976ad480bdfc52fd81676a),
    .INIT_8(256'h4876675053505e0c4a4c5f7543494a204a4043455a4e5b5b3b195f6253205377),
    .INIT_9(256'hf35e5355eb46627c5e10c2f5da726658f2334a59c63c46f5761deeeb1a2a0a25),
    .INIT_A(256'h7151045ca43988e03081f5d1208c04502010c04599017c44fae9cff156c25bdb),
    .INIT_B(256'h9cf08511e158e4c0bdc4ac7c644d514544c80c18a810980df4aca120c979c14c),
    .INIT_C(256'h98f8180cc833584170cbed7ee91e8c9ee21eaa984a1029401bd178544b3f8eae),
    .INIT_D(256'h4504cb22ba2a778836a1c4811bccf129baba2a396df31e153984f445a909c9a9),
    .INIT_E(256'heef50285e1adcb366284248400a6cc8115824483a9094fccb00247a1b2169a7a),
    .INIT_F(256'h5913bcaafdca040cd14e4107d83083a459ab0e0978a8412fcc392d2c9c400a01)
  ) _bn02 (
    .RDATA(insn0[5:4]),
    .RADDR(code_addr[10:0]),
    .RCLK(clk), .RCLKE(1'b1), .RE(1'b1),
    .WCLK(clk), .WCLKE(unlocked), .WE(mem_wr & !mem_addr[12]),
    .WADDR(mem_addr[11:1]),
    .MASK(16'h0000), .WDATA(dout[5:4]));

  SB_RAM2048x2 #(
    .INIT_0(256'hb01408288020040290c1a485028300d00090231680cc90d4304a04ce24b17b0b),
    .INIT_1(256'h909004d4339000a000a300011000b0001120002000820888248803a802480004),
    .INIT_2(256'h808050f0009000a1231012a2802010110030201800a800201000894830108020),
    .INIT_3(256'ha80101741c70024004252118421600a80a1a102122128092001000000031b580),
    .INIT_4(256'h06380c88a0c7285a005f0449324990a088e10050645440c209fa10a1441300bc),
    .INIT_5(256'h101a000289c182c0003462871042203300bf0c5720106546194a006b00801a60),
    .INIT_6(256'hb0fb1c600fcb6028025880da004932025088326c409358120950934040094a48),
    .INIT_7(256'h0070217d08c11c78b0c1226100ca1653902b02f40157194e00ed0ad620f50245),
    .INIT_8(256'h116a04062453001c0848101534430c0a004a000b20520d434019004a30639859),
    .INIT_9(256'h29003050212018688402204200a6084211228043384e00e401568cfb184a6008),
    .INIT_A(256'h64090c80240185448120d4ad8c200041210061c0608114682008044f94029450),
    .INIT_B(256'h801c60a5006908a4c0311dac0474150c00f4b804e8484c15ed34200868855081),
    .INIT_C(256'h7eee630819d2c00a4820947882e30c0889eae98248222c05263b560c022b43cc),
    .INIT_D(256'h3071aa61a0926112e112c0249a61b0a132185108e128e07aa0982254a6c9d647),
    .INIT_E(256'h953e10822cad9ad93a6a2525fbf8d94c41058084983170256c284106516a286a),
    .INIT_F(256'h6550e5b58c9c25451051306188d88189585c3000a8bc874693dd1c244058650b)
  ) _bn03 (
    .RDATA(insn0[7:6]),
    .RADDR(code_addr[10:0]),
    .RCLK(clk), .RCLKE(1'b1), .RE(1'b1),
    .WCLK(clk), .WCLKE(unlocked), .WE(mem_wr & !mem_addr[12]),
    .WADDR(mem_addr[11:1]),
    .MASK(16'h0000), .WDATA(dout[7:6]));

  SB_RAM2048x2 #(
    .INIT_0(256'h1c73400240f0aba82082a2a801490b3e2e8ac19c00de301e222146e48bf0e54e),
    .INIT_1(256'ha080205ed5304848d17da2eaf31988aa0b09a4ac000824424298c0489818b80a),
    .INIT_2(256'h446808542ecae69ce2ca9011494a0016a4c2047ac95ac88a8862210211074a8a),
    .INIT_3(256'h6256a0a9868264b5e286a3a128b58e02a081e01a2cbc7ce8109c3cc26eca303c),
    .INIT_4(256'ha9fa8a757cd89c80a0122bec06c83c7a0c2226a060810010e0e3d2b2be21ac11),
    .INIT_5(256'h3c694bbf07310a7d84f9949854da6454edfa786ef1d610c6480540cc80c01a45),
    .INIT_6(256'ha80d19b18298040c890dc241c2cc8a80b43c4ca004031d87a63682010cbca0e8),
    .INIT_7(256'h81a1101890308226bc3c028eaaae3206123f84b1041016b11e380a90249c848c),
    .INIT_8(256'h10301218082c3f1a0805042a103c042a342c0a0821252c22040c082214172821),
    .INIT_9(256'h082e1426809c022a040288be092f0a1c84a0020086a884228e1884201c160034),
    .INIT_A(256'hc0a9a89914f13000888868089dd880157010546c01200128808902389d989cba),
    .INIT_B(256'h4018389d3cbc8114201944882925909cacb85814b0b42809f8bc1479683da089),
    .INIT_C(256'h082780b9ccab0d3fa8b9808910663d70307b3b323a381eaa4ef9460202fbd00c),
    .INIT_D(256'h522a8baa454600fd9291006582d23551545c90ddb0984203b0fb862b083ac5b3),
    .INIT_E(256'h8e9908c38cba0a1f59ce9cf188faae98c6c2b88e8cb8b0470da512c720f38821),
    .INIT_F(256'h824a94a298870a182e3a05cf8fa8f4978c5290558da0025282dc4852114d000d)
  ) _bn04 (
    .RDATA(insn0[9:8]),
    .RADDR(code_addr[10:0]),
    .RCLK(clk), .RCLKE(1'b1), .RE(1'b1),
    .WCLK(clk), .WCLKE(unlocked), .WE(mem_wr & !mem_addr[12]),
    .WADDR(mem_addr[11:1]),
    .MASK(16'h0000), .WDATA(dout[9:8]));

  SB_RAM2048x2 #(
    .INIT_0(256'h101800c402d406872202203100110ba12284304ca0b020941034a82aa48dc4ad),
    .INIT_1(256'h2125200080c048d0d5a43125a0c00800000722a80234a2920040015908a8a090),
    .INIT_2(256'h4400004028a0b0c03160a4804301022026902638cb8d1204a2882205048500d4),
    .INIT_3(256'h22041086e46004c02290c1432090001894013040044038500010008038400180),
    .INIT_4(256'ha12410003000941200562051110801c14048101020900012b08280c01090a588),
    .INIT_5(256'h200000c001814900802050c00080440040910928e00200c010400084088a042c),
    .INIT_6(256'hb38401ae00800410c05083830a9a9c4c644810400186858c8400909404808060),
    .INIT_7(256'h84b41030189810008c90008020800808012008a9020001811022009804041414),
    .INIT_8(256'h08281000022c121010181000003202020020000000140232001a001204273008),
    .INIT_9(256'h022084a082800332020082a400b8800280a0000080b20aa8020a82b002041028),
    .INIT_A(256'h006180a15060000020a0005851f120a830404c4080a08139888008080080009a),
    .INIT_B(256'h48441401110910053020405001100000bc85444050c0002430f01020104100a9),
    .INIT_C(256'h0161002084c04140800000804081500070c01081102010a250a9004102a20048),
    .INIT_D(256'h0aaac4ac509050f00088027010c0404040114048908000481898183000381181),
    .INIT_E(256'h9aca1a5010f810810080986050e8308082000884568e5045052500c212400426),
    .INIT_F(256'hc2c080a000d018401a00049180801490504080c080f200405280025041481082)
  ) _bn05 (
    .RDATA(insn0[11:10]),
    .RADDR(code_addr[10:0]),
    .RCLK(clk), .RCLKE(1'b1), .RE(1'b1),
    .WCLK(clk), .WCLKE(unlocked), .WE(mem_wr & !mem_addr[12]),
    .WADDR(mem_addr[11:1]),
    .MASK(16'h0000), .WDATA(dout[11:10]));

  SB_RAM2048x2 #(
    .INIT_0(256'he71156007a002720020021015900afb08e00fd0036600e007743eaa2ce12b480),
    .INIT_1(256'h21010a50e100ca80f510eb0041003c001f006e042a02c301f400fba0be801800),
    .INIT_2(256'h76000c00ef21dc00eb802500eb212e0096007e00ff01cb81720087006f047620),
    .INIT_3(256'hb6042b20e70075004a408300390c5610e5215800c410780094007b21ca000d00),
    .INIT_4(256'he3107700110097107242ff40c90869283200b20011101212a302a300b9085500),
    .INIT_5(256'h69001f0233017d00c150b90009004410d1003b10d70110100500060ac20a2560),
    .INIT_6(256'h0705030214000408c50043405f42ed402c008c088f09a700ae121d003400a400),
    .INIT_7(256'h050110083c1004213d000c0224020c02052a891022102302130090019d009c80),
    .INIT_8(256'h0b001a020600310216022a021e022600360a0202270226000e000a080f08a300),
    .INIT_9(256'h220086821302070086003f00830096000600920232021b000210060006002b08),
    .INIT_A(256'hc5807100780050003c0860207120fc0050007c40910199000c001a020f002200),
    .INIT_B(256'h6c101d0895041900280061202920a0200d00e50014007010b12055000900b901),
    .INIT_C(256'h210090080500b50091000308770173011402570216025602610107015e025904),
    .INIT_D(256'hc3494501154318005b02130004000d40074988001a008b42df00190016102100),
    .INIT_E(256'h0f001b08320021015541dc08070037048700371c46241301e701321487008782),
    .INIT_F(256'hae00721013101a002b01df81474176400200b50033005800620c52401d10de10)
  ) _bn06 (
    .RDATA(insn0[13:12]),
    .RADDR(code_addr[10:0]),
    .RCLK(clk), .RCLKE(1'b1), .RE(1'b1),
    .WCLK(clk), .WCLKE(unlocked), .WE(mem_wr & !mem_addr[12]),
    .WADDR(mem_addr[11:1]),
    .MASK(16'h0000), .WDATA(dout[13:12]));

  SB_RAM2048x2 #(
    .INIT_0(256'h10e6009400fa50b700de40bd004d00ff408600bf015e000e807610ca00dd0035),
    .INIT_1(256'h02f8005a00bf01da00ec00eb0009107cc01701fe403a00ca00b800ef41be4018),
    .INIT_2(256'h31ee005c00ce001c04eb422d14e200fe005601fa00fe00ea007200c710e900a6),
    .INIT_3(256'h40b600ab00ef00fe00de048322b500d202e5049802d421fe429c00fc00ce428d),
    .INIT_4(256'h00f308f700d4088300f200ff00cd00ed10a600b6429d055a04cb006744b00051),
    .INIT_5(256'h10e500ff01bf00fd00dd001c00a900f6007f00dd08d700d628c500ee205b00f5),
    .INIT_6(256'h600f0863709c007c205f2047005d01ec01ac10aa00ff10e7403e403d007400ff),
    .INIT_7(256'hc035047840ac01ec403c106d412c10ec40bd007f40be00ff503f29d040bc00fb),
    .INIT_8(256'h007d711e004640372856402c007f512a017e740a006f4836205e057a401f14e1),
    .INIT_9(256'h40141964403c004d6190805f40b721d6481524dbc10e00f7609700536916104d),
    .INIT_A(256'h00ad0079005800f440fd00a400f000fc885c407d00f400c8401c007c40a911e6),
    .INIT_B(256'h01fc00fd00f5409900e804e9807d403c100d01b4109d8070203900cd002520fd),
    .INIT_C(256'h0846007a005f00bf04fb009f00fd8877009e00dfa11600fa08c5806302fe00bf),
    .INIT_D(256'h14c910450054049800df0cf300cc20cd106d041a301e04eb007f00dd00f640a1),
    .INIT_E(256'h006b205700c600a500dc02c000a700b708e640af00a200b308c608e600ef0887),
    .INIT_F(256'h002e005b0877a05f002f20df0066007e08a6003d0857007d00ef807e201e00fe)
  ) _bn07 (
    .RDATA(insn0[15:14]),
    .RADDR(code_addr[10:0]),
    .RCLK(clk), .RCLKE(1'b1), .RE(1'b1),
    .WCLK(clk), .WCLKE(unlocked), .WE(mem_wr & !mem_addr[12]),
    .WADDR(mem_addr[11:1]),
    .MASK(16'h0000), .WDATA(dout[15:14]));

  SB_RAM2048x2 #(
    .INIT_0(256'hfffdfefffdfdfcfcfdfefcfffdfffefcfffcfdfffcfcfcfdfcfffefefffdfdfc),
    .INIT_1(256'hfffffdfdfcfefcfefffffcfcfdfefefcfdfffefdfcfcfcfefcfffffcfdfcfdfe),
    .INIT_2(256'hfcfefefdfffffffdfefdfffffdfefffcfdfcfdfdfcfffffffcfffefcfffdfffe),
    .INIT_3(256'hfffffefdfcfcfffdfefefefdfcfcfffefffdfffdfdfdfefffffdfffffdfffdff),
    .INIT_4(256'hfffcfffcfcfcfffefdfefdfcfcfdfcfcfefcfffffffdfcfefefdfefefefdfcfe),
    .INIT_5(256'hfdfcfffcfefcfdfcfdfefffcfdfefdfcfffdfefefcfefdfcfffcfefefdfffeff),
    .INIT_6(256'hfefcfefdfefdfefdfffdfcfcfdfcfefffefcfefcfffffffefffefdfcfefefdfd),
    .INIT_7(256'hfffefefffdfcfdfdfffcfcfdfdfefefefcfdfdfcfffefcfcfcfefffdfffefefd),
    .INIT_8(256'hfefcfdfcfffcfdfffcfcfefffefcfcfffefcfefefefcfcfefefdfefefffcfdff),
    .INIT_9(256'hfefefefefffcfefffffefffefffffefdfcfdfefffdfffefffefdfcfcfefcfefd),
    .INIT_A(256'hfefefcfcfefcfefefefefefefefefefcfefefcfefcfcfefefefefefefcfcfefc),
    .INIT_B(256'hfcfcfcfefcfcfefcfcfcfcfefefefefcfcfcfefcfefcfefefcfefefefcfefcfe),
    .INIT_C(256'hfdfdfefdfffcfffefefefffefffefffefffdfcfcfcfefcfefcfcfcfefefcfefc),
    .INIT_D(256'hfffcfcfdfcfcfefefefdfefdfefcfffdfcfefdfffefdfdfdfffffefffffcfdfd),
    .INIT_E(256'hfdfdfffdfdfefcfffcfffefcfdfdfffefcfcfffcfffefffcfffefdfcfefffffe),
    .INIT_F(256'hfffefefffffffffffefefffffffefefefdfdfdfdfffcfdfdfffdfcfefcfdfefd)
  ) _bn10 (
    .RDATA(insn1[1:0]),
    .RADDR(code_addr[10:0]),
    .RCLK(clk), .RCLKE(1'b1), .RE(1'b1),
    .WCLK(clk), .WCLKE(unlocked), .WE(mem_wr & mem_addr[12]),
    .WADDR(mem_addr[11:1]),
    .MASK(16'h0000), .WDATA(dout[1:0]));

  SB_RAM2048x2 #(
    .INIT_0(256'hfcfffefdfdfffcfdfffcfcfefdfdfefcfdfdfefefdfdfcfcfdfffdfcfcfffefc),
    .INIT_1(256'hfdfefcfffdfffefffffdfefdfcfffffffefefdfdfdfefdfefffffefffffefdfd),
    .INIT_2(256'hfcfffffdfefcfdfefcfcfffdfcfdfcfefefffffcfffdfefefdfffdfdfdfefeff),
    .INIT_3(256'hfdfffffdfdfcfcfdfcfffffdfcfdfcfcfdfdfefefffffcfdfdfffffdfffffcfe),
    .INIT_4(256'hfcfdfcfdfcfffcfcfcfefcfefffefffefffdfffdfcfefefefefcfffffcfefefe),
    .INIT_5(256'hfcfffefefdfdfffffcfcfefefefefefffcfcfffdfcfdfcfdfefdfdfefcfefcfd),
    .INIT_6(256'hfcfffefcfffdfcfefcfefcfdfffffdfdfefefcfdfcfcfffdfcfdfffdfdfdfdfe),
    .INIT_7(256'hfdfcfffdfffdfcfffffdfffffdfffdfefffefefdfdfffcfffcfefcfefcfcfcff),
    .INIT_8(256'hfefefefefefffcfcfcfcfcfdfcfdfffcfefdfefcfcfdfefdfffcfdfcfcfcfffc),
    .INIT_9(256'hfefcfdfdfdfffcfcfefdfcfdfcfffefffdfcfdfffcfefdfcfdfffdfdfefefcfe),
    .INIT_A(256'hfefefcfefcfefefefcfcfcfefefcfcfefefefefcfcfefefcfefefcfcfcfefcfe),
    .INIT_B(256'hfcfcfcfefcfefcfefcfcfefcfcfcfefefefefcfcfcfefefcfefefefefefcfefe),
    .INIT_C(256'hfcfcfcfcfcfdfefdfcfdfcfcfcfefcfefefdfcfcfcfefefcfcfefcfcfcfefcfe),
    .INIT_D(256'hfefcfcfcfdfdfefefcfdfefcfcfdfdfffffffdfffdfffefefdfdfdfffffcfcfd),
    .INIT_E(256'hfcfdfdfffffffcfffffdfffffffdfefdfcfcfffdfefffefffcfdfffefcfdfcff),
    .INIT_F(256'hfffefefefffefffffefefefefefffefefcfcfefcfffdfefdfcfffffffffdfffd)
  ) _bn11 (
    .RDATA(insn1[3:2]),
    .RADDR(code_addr[10:0]),
    .RCLK(clk), .RCLKE(1'b1), .RE(1'b1),
    .WCLK(clk), .WCLKE(unlocked), .WE(mem_wr & mem_addr[12]),
    .WADDR(mem_addr[11:1]),
    .MASK(16'h0000), .WDATA(dout[3:2]));

  SB_RAM2048x2 #(
    .INIT_0(256'hfffefffcfffefefefefcfffcfefcfcfcfdfcfefefffdfdfefefdfcfdfffcfdff),
    .INIT_1(256'hfdfcfffcfcfcfffefffcfcfefefffefcfefdfefffefffffcfcfdfcfdfcfcfdfc),
    .INIT_2(256'hfcfefcfdfffffffefefefffcfffdfdfdfffffdfefefdfefefcfdfefffffefffd),
    .INIT_3(256'hfffcfcfffcfdfffcfffcfdfefcfcfffffdfdfcfdfcfcfcfcfffffffefdfdfcff),
    .INIT_4(256'hfdfffdfcfcfcfffefffcfcfcfefcfcfdfffffffefcfcfcfefffefffffcfcfdff),
    .INIT_5(256'hfffefdfefefefffefdfcfdfffdfcfefefefffefcfefdfefdfdfcfffefefcfcfd),
    .INIT_6(256'hfefdfdfdfcfffffcfcfcfefcfdfefcfffefcfdfcfdfffffcfcfefffefcfcffff),
    .INIT_7(256'hfcfcfefdfffcfdfefffefefdfdfcfffefdfcfcfefefffcfefcfcfffffdfdfefe),
    .INIT_8(256'hfdfcfcfdfcfffcfdfcfcfefcfdfcfffefcfcfefcfcfdfefefdfefffcfcfcfffe),
    .INIT_9(256'hfefcfcfefffffcfefffcfdfefcfdfdfcfffefdfefffcfcfcfcfefefefefefcfd),
    .INIT_A(256'hfcfcfefcfefefefefcfefefefefcfefefefefefefefcfefcfefcfcfefefefcfc),
    .INIT_B(256'hfefefefefcfcfefcfefcfcfefcfcfefcfcfefefefefefefcfcfcfefefcfefcfc),
    .INIT_C(256'hfcfefcfdfdfdfffcfcfefdfefdfcfefcfdfffcfcfcfcfcfefcfcfcfefefefefc),
    .INIT_D(256'hfcfefdfdfcfefcfcfdfcfffefcfefcfcfcfefcfcfefdfcfffcfefefdfcfffcfd),
    .INIT_E(256'hfffcfdfcfdfefcfcfffffefcfcfefffcfdfdfffefffefcfcfdfefdfffcfefffc),
    .INIT_F(256'hfffffefffffffefefefefefffffefffffdfdfdfefffefcfcfcfdfcfefcfffffe)
  ) _bn12 (
    .RDATA(insn1[5:4]),
    .RADDR(code_addr[10:0]),
    .RCLK(clk), .RCLKE(1'b1), .RE(1'b1),
    .WCLK(clk), .WCLKE(unlocked), .WE(mem_wr & mem_addr[12]),
    .WADDR(mem_addr[11:1]),
    .MASK(16'h0000), .WDATA(dout[5:4]));

  SB_RAM2048x2 #(
    .INIT_0(256'hfefcfcfffcfffcfefcfefdfffcfefcfcfcfcfcfcfdfffdfdfcfefcfcfefefcfd),
    .INIT_1(256'hfcfdfcfcfefffcfdfcfffcfcfcfefdfefcfcfcfefcfefcfefcfcfcfcfefcfdfd),
    .INIT_2(256'hfffcfcfcfdfdfcfffcfefcfefdfffdfdfdfcfcfdfefefefefcfcfcfefdfffdfe),
    .INIT_3(256'hfcfcfcfefcfcfcfefcfdfcfffcfcfcfefcfdfcfefefcfcfefcfffcfcfcfffefc),
    .INIT_4(256'hfffcfcfffdfcfcfefcfefcfcfdfefefcfefefcfdfefcfdfcfefefcfcfefcfcfd),
    .INIT_5(256'hfffcfffcfcfdfefcfcfcfefdfcfffcfefdfefdfefcfffcfdfdfcfffcfdfffcfd),
    .INIT_6(256'hfdfdfffdfffffcfffcfcfdfdfdfdfdfdfefefcfdfcfdfefdfcfcfdfefdfcfefc),
    .INIT_7(256'hfcfefefcfffffcfefdfdfcfefcfdfefdfefdfcfcfdfffcfefcfefcfffcfdfefe),
    .INIT_8(256'hfdfdfffcfcfcfcfcfffffcfffefdfcfffcfefefcfefdfdfefcfefcfefefcfdff),
    .INIT_9(256'hfefcfdfcfefcfcfcfefcfdfcfefdfcfffcfdfcfffcfffcfcfcfcfffefefefcfc),
    .INIT_A(256'hfcfcfefefefefefefcfcfefcfefcfefefefefcfefcfcfefcfcfcfcfcfcfefcfc),
    .INIT_B(256'hfcfefcfefcfcfcfcfefefefcfcfcfefefcfcfefcfefcfefefefcfcfcfcfefcfc),
    .INIT_C(256'hfdfdfffdfffcfefdfdfcfcfcfefcfcfcfcfefcfcfcfcfcfefcfcfcfcfefefefe),
    .INIT_D(256'hfcfefdfcfdfcfcfcfefdfefffefefffcfdfcfcfcfffcfcfcfcfcfdfcfdfffdfd),
    .INIT_E(256'hfefefefdfcfdfcfcfdfefdfcfcfcfffefcfcfcfefdfefefcfdfcfcfcfcfcfcfd),
    .INIT_F(256'hfffffefefefefefefefefefefffefefefcfdfcfdfefffefefffdfdfcfcfcffff)
  ) _bn13 (
    .RDATA(insn1[7:6]),
    .RADDR(code_addr[10:0]),
    .RCLK(clk), .RCLKE(1'b1), .RE(1'b1),
    .WCLK(clk), .WCLKE(unlocked), .WE(mem_wr & mem_addr[12]),
    .WADDR(mem_addr[11:1]),
    .MASK(16'h0000), .WDATA(dout[7:6]));

  SB_RAM2048x2 #(
    .INIT_0(256'hfcfdfcfefdfcfcfffefcfdfffefdfefefffcfcfdfdfffdfdfdfdfdfcfcfffcfe),
    .INIT_1(256'hfefffefdfdfdfcfcfdfefdfffcfcfcfcfdfffdfffefefffffffdfefcfcfdfcfc),
    .INIT_2(256'hfffffefefefefcfffcfcfcfefefcfcfefefcfcfffffdfcfffcfdfcfdfcfefefc),
    .INIT_3(256'hfdfffdfdfdfcfefffcfefdfdfdfdfcfcfdfffffdfcfdfefefdfffefffdfdfeff),
    .INIT_4(256'hfefcfcfdfdfdfcfcfcfcfdfcfefcfcfdfefefcfefcfdfefefefffcfefdfdfefe),
    .INIT_5(256'hfffdfffcfcfefefcfcfcfefcfffdfcfdfcfcfcfefefdfcfefdfdfffefffffefc),
    .INIT_6(256'hfcfcfcfdfcfdfcfefcfefcfcfcfefcfffcfcfcfcfcfffcfdfcfffcfcfefcfefc),
    .INIT_7(256'hfcfdfdfdfcfcfcfffcfcfcfffcfefefffcfcfdfffcfefdfffcfefcfffcfffcfd),
    .INIT_8(256'hfefefcfcfefefefffffcfcfffcfcfdfcfdfcfcfdfcfdfdfdfcfcfcfefdfcfcfc),
    .INIT_9(256'hfcfcfcfefcfdfdfffcfdfdfffcfdfcfffcfcfcfefdfffffffefffefcfefcfefe),
    .INIT_A(256'hfcfefcfcfcfcfefefcfefcfefcfcfcfcfefefcfcfcfcfcfefcfcfcfefefefcfc),
    .INIT_B(256'hfcfcfcfefcfcfefefcfcfcfefcfefcfcfcfcfcfcfcfcfcfcfcfefcfefcfcfcfc),
    .INIT_C(256'hfdfdfcfcfcfcfcfdfdfffcfefcfcfdfffcfdfcfcfcfcfcfcfcfcfcfcfcfefcfc),
    .INIT_D(256'hfdfdfcfdfcfcfcfefcfcfffffdfffcfdfefefcfdfcfcfdfffcfffcfefcfcfcfc),
    .INIT_E(256'hfcfffdfcfefefcfdfcfdfcfcfcfffdfffdfefcfcfdfdfdfcfdfffdfefcfefcfe),
    .INIT_F(256'hfefefefefefefefffefffefffffffffefcfdfcfffefefcfffcfdfefefdfffffe)
  ) _bn14 (
    .RDATA(insn1[9:8]),
    .RADDR(code_addr[10:0]),
    .RCLK(clk), .RCLKE(1'b1), .RE(1'b1),
    .WCLK(clk), .WCLKE(unlocked), .WE(mem_wr & mem_addr[12]),
    .WADDR(mem_addr[11:1]),
    .MASK(16'h0000), .WDATA(dout[9:8]));

  SB_RAM2048x2 #(
    .INIT_0(256'hfcfcfcfcfcfdfdfffefefefffcfffcfcfcfcfcfdfdfdfcfdfffcfefcfcfcfcfe),
    .INIT_1(256'hfcfcfcfcfcfcfcfcfcfcfcfffcfefcfcfefcfdfefffefcfcfdfcfdfcfcfdfcfc),
    .INIT_2(256'hfcfcfdfefcfcfcfcfcfcfdfefcfdfefffcfcfcfefdfcfcfdfcfdfcfefcfffefe),
    .INIT_3(256'hfcfdfdfefcfcfcfefcfcfdfffdfdfcfcfefffcfcfcfdfcfcfcfdfcfcfcfffcfd),
    .INIT_4(256'hfcfcfcfcfcfcfcfcfcfefffffcfcfcfdfdfcfefdfdfffefcfcfdfffcfdfffefc),
    .INIT_5(256'hfcfcfdfcfffcfcfdfefefcfdfdfffcfcfcfcfcfefcfcfffefefefcfcfcfefffe),
    .INIT_6(256'hfcfcfefcfcfcfefdfcfefcfcfcfdfcfefcfefcfcfcfffcfdfcfffcfefefefcfd),
    .INIT_7(256'hfcfdfdfcfcfffcfcfcfdfcfffcfcfdfcfcfdfcfffefcfcfcfcfcfefdfcfefcff),
    .INIT_8(256'hfcfcfdfcfcfcfefffcfcfefcfcfcfdfdfcfdfcfcfcfcfcfcfcfcfefcfdfdfcfc),
    .INIT_9(256'hfcfcfcfefcfcfdfffcfcfcfefcfdfdfdfdfdfcfefdfffdfcfcfcfcfcfcfcfcfc),
    .INIT_A(256'hfcfefcfefcfefefefcfefefcfcfcfcfefefefcfcfcfcfefcfcfcfcfefcfefcfc),
    .INIT_B(256'hfcfcfefefcfefcfcfcfcfefcfcfefcfcfcfcfcfcfcfcfcfefefcfcfefcfcfcfc),
    .INIT_C(256'hfcfcfdfcfcfcfcfcfcfefcfefcfcfcfcfcfefcfcfcfcfcfcfcfcfcfcfefcfcfc),
    .INIT_D(256'hfdfffcfcfcfcfcfefcfcfcfcfefcfcfefefcfcfdfdfcfcfcfcfffdfcfcfefdfc),
    .INIT_E(256'hfefcfcfffefdfcfdfcfcfcfcfcfffefcfdfefefdfcfcfdfcfcfefdfcfcfefcfc),
    .INIT_F(256'hfffefefefefffefffffefefffefefffefcfdfcfefcfdfefdfcfefefcfdfefcfd)
  ) _bn15 (
    .RDATA(insn1[11:10]),
    .RADDR(code_addr[10:0]),
    .RCLK(clk), .RCLKE(1'b1), .RE(1'b1),
    .WCLK(clk), .WCLKE(unlocked), .WE(mem_wr & mem_addr[12]),
    .WADDR(mem_addr[11:1]),
    .MASK(16'h0000), .WDATA(dout[11:10]));

  SB_RAM2048x2 #(
    .INIT_0(256'hfdfcfcfcfdfdfffefefdfefcfefefefefdfffdfdfcfcfcfcfffefefcfdfefcfc),
    .INIT_1(256'hfefcfdfefcfcfcfcfdfdfdfdfefffffefefcfffcfefcfefefffefdfefefcfcfc),
    .INIT_2(256'hfcfcfcfcfcfcfcfcfcfcfffcfefefefcfcfefcfcfdfcfcfcfcfcfefefefcfefc),
    .INIT_3(256'hfefcfdfcfcfcfdfefefcfdfcfdfcfcfdfefcfcfefefcfcfcfcfcfcfcfcfcfcfc),
    .INIT_4(256'hfcfefcfcfcfcfcfcfefcfffcfcfffefcfcfcfffcfdfcfefdfcfcfefcfdfcfefd),
    .INIT_5(256'hfcfefcfefcfcfcfefefefdfffdfcfdfcfefdfffcfefefefcfefefcfcfefefffc),
    .INIT_6(256'hfcfdfcfcfcfcfffcfdfdfcfdfcfcfcfcfdfcfcfcfdfcfdfdfdfdfefffffcfcfe),
    .INIT_7(256'hfcfcfdfcfcfcfdfcfefcfefefefcfdfcfffdfdfdfcfdfcfcfcfcfffcfdfcfdfc),
    .INIT_8(256'hfcfefffcfcfefcfefcfefcfcfcfcfdfcfdfcfcfdfcfcfcfcfcfcfcfcfdfcfcfd),
    .INIT_9(256'hfcfcfdfcfcfdfcfdfcfdfcfcfcfcfcfdfdfcfdfdfffcfefffcfffdfefcfefcfe),
    .INIT_A(256'hfcfcfcfcfcfcfcfefcfcfcfcfcfcfcfcfefefcfcfcfcfefcfcfcfcfcfcfcfcfc),
    .INIT_B(256'hfcfcfefcfefcfcfefcfcfefcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfc),
    .INIT_C(256'hfcfcfdfcfcfcfcfcfcfcfcfcfcfcfffdfcfdfcfcfcfcfcfcfcfcfcfcfefcfcfc),
    .INIT_D(256'hfdfcfcfdfdfcfcfcfcfcfdfdfffcfcfdfffcfcfcfcfcfcfcfcfcfefcfcfcfcfc),
    .INIT_E(256'hfffcfdfcfffcfdfcfcfdfdfcfcfcfefcfcfcfcfcfcfcfcfcfcfcfcfcfcfcfefc),
    .INIT_F(256'hfefefefefefefefefffefefefefefefefdfcfdfcfdfcfffcfcfdfffcfdfcfcfc)
  ) _bn16 (
    .RDATA(insn1[13:12]),
    .RADDR(code_addr[10:0]),
    .RCLK(clk), .RCLKE(1'b1), .RE(1'b1),
    .WCLK(clk), .WCLKE(unlocked), .WE(mem_wr & mem_addr[12]),
    .WADDR(mem_addr[11:1]),
    .MASK(16'h0000), .WDATA(dout[13:12]));

  SB_RAM2048x2 #(
    .INIT_0(256'hfcfffcfefcfdfcfffcfefcfcfcfffdfefcfdfcfdfcfefefcfcfffcfffcfdfcfc),
    .INIT_1(256'hfcfffcfdfcfdfcfefcfffcfffcfefcfffcfffcfffcfefcfffcfffcfcfcfffefd),
    .INIT_2(256'hfcfffcfefcfffcfffdfcfcfefcfffcfffcfdfcfdfcfffefdfcfffcfffcfffcff),
    .INIT_3(256'hfcfefcfffefdfefdfcfefcfffefcfcfcfcfefcfdfcfffcfffcfffcfffcfffcff),
    .INIT_4(256'hfcfdfcfdfefdfdfcfcfefcfefcfcfcfefcfffcfdfcfffcfefcfefcfdfcfefcfe),
    .INIT_5(256'hfcfdfdfcfcfdfefdfcfefcfdfcfdfcfdfcfcfcfffcfffcfefcfffdfefcfffcfe),
    .INIT_6(256'hfcfefcfefcfffcfdfcfffefcfcfefcfffdfefefcfcfffcfffcfffcfefcfdfcfd),
    .INIT_7(256'hfefcfcfdfcfffcfffcfdfcfffcfefcfffcfffcfffcfcfcfefdfefcfdfcfffcff),
    .INIT_8(256'hfcfdfcfefefdfcfffcfdfcfdfcfefcfffefdfcfcfcfefcfffffcfcfcfcfefcfe),
    .INIT_9(256'hfcfefcfffdfefcfffcfefcfefcfffcfffefdfcfffcfffcfffcfcfcfdfdfcfcfd),
    .INIT_A(256'hfcfefcfefcfefefcfcfefcfcfcfefcfefefefcfefefcfcfcfcfefcfefcfefefc),
    .INIT_B(256'hfcfcfcfefcfefcfcfcfcfcfcfcfefcfefcfefcfefcfefcfefcfefcfefcfefefc),
    .INIT_C(256'hfefdfcfefcfffcfffcfffdfefcfefcfffcfefefcfcfefcfefefcfcfefcfcfcfe),
    .INIT_D(256'hfcfffefcfefdfdfefcfefcfffcfdfcfefcfffcfffcfffcfffcfffcfffcfffefc),
    .INIT_E(256'hfcfdfcfffcfffcfffcfefefdfcfffcfdfdfefcfffefdfdfefcfffdfefcfffcfe),
    .INIT_F(256'hfefefefffefffefffefefefffefffffefcfdfcfdfcfffcfdfcfefcfffcfffcff)
  ) _bn17 (
    .RDATA(insn1[15:14]),
    .RADDR(code_addr[10:0]),
    .RCLK(clk), .RCLKE(1'b1), .RE(1'b1),
    .WCLK(clk), .WCLKE(unlocked), .WE(mem_wr & mem_addr[12]),
    .WADDR(mem_addr[11:1]),
    .MASK(16'h0000), .WDATA(dout[15:14]));

    reg c11;
    always @(posedge clk) c11 <= code_addr[11];
    wire [15:0] cm = {16{c11}};
    assign insn = (cm & insn1) | (~cm & insn0);
    // assign insn = c11 ? insn1 : insn0;

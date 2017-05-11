/* Quartus II 64-Bit Version 15.0.2 Build 153 07/15/2015 SJ Web Edition */
JedecChain;
	FileRevision(JESD32A);
	DefaultMfr(6E);

	P ActionCode(Ign)
		Device PartName(SOCVHPS) MfrSpec(OpMask(0));
	P ActionCode(Cfg)
		Device PartName(5CSEMA5) Path("./") File("de1soc_soc.jic") MfrSpec(OpMask(1) SEC_Device(EPCQ256) Child_OpMask(1 1));

ChainEnd;

AlteraBegin;
	ChainType(JTAG);
AlteraEnd;

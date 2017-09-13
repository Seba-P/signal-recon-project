/* Quartus Prime Version 16.1.0 Build 196 10/24/2016 SJ Lite Edition */
JedecChain;
	FileRevision(JESD32A);
	DefaultMfr(6E);

	P ActionCode(Ign)
		Device PartName(SOCVHPS) MfrSpec(OpMask(0));
	P ActionCode(Cfg)
		Device PartName(5CSEMA5) Path("D:/SEBA/BACKUP/Projekty/FPGA+ARM/signal-recon-project/de1soc/hw/release/") File("de1soc_soc.jic") MfrSpec(OpMask(1) SEC_Device(EPCQ256) Child_OpMask(1 3));

ChainEnd;

AlteraBegin;
	ChainType(JTAG);
AlteraEnd;

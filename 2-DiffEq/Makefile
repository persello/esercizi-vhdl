VHDLDIR=VHDL
WORKDIR=WORK
VCDDIR=VCD
VECDIR=OUTVECS
MAIN=testBench
TIME="100ns"
#
GHDL=ghdl
GHDLFLAGS=--ieee=synopsys --std=08
GHDLRUNFLAGS=--vcd=$(MAIN).vcd --stop-time=$(TIME)

all: run

run: elaboration
	$(GHDL) -c $(GHDLFLAGS) -r $(MAIN) $(GHDLRUNFLAGS)
	mv $(MAIN).vcd $(VCDDIR)
	mv *.cf $(WORKDIR)

elaboration : analysis
	$(GHDL) -c $(GHDLFLAGS) -e $(MAIN)

analysis: clean
	$(GHDL) -a $(GHDLFLAGS) $(VHDLDIR)/diffeq.vhd
	$(GHDL) -a $(GHDLFLAGS) $(VHDLDIR)/vectorGenerator.vhd
	$(GHDL) -a $(GHDLFLAGS) $(VHDLDIR)/$(MAIN).vhd

clean: prepare
	@rm -f $(WORKDIR)/*.cf $(VCDDIR)/*.vcd *.cf *.vcd

prepare: force
	mkdir -p $(WORKDIR)
	mkdir -p $(VCDDIR)
	mkdir -p $(VECDIR)

force:

BINARY=example-parser.bin
GENERATED=lex.yy.c

all: $(BINARY)

$(BINARY): $(GENERATED)
	g++ -o $@ $^ -lfl -g

$(GENERATED): main.yy
	lex $^

clean:
	rm $(BINARY) $(GENERATED)

test: all
	cat testProject.pro | ./$(BINARY)

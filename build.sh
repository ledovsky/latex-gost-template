
# Pdflatex
PDFLATEX='pdflatex -interaction=nonstopmode -shell-escape -file-line-error'
GREP='grep ".*:[0-9]*:.*"' # показывает на выходе только ошибки

# Файлы/Папки
PDF_NAME='thesis.pdf'
TEX='tex'
INC='inc'
GOST='gost'
MAINTEX='main'

# Копирование файлов из папки gost
cd $GOST
cp -r * ../$TEX
cd ..

# Конвертация eps
find -E $INC/ -type f -name "*.eps" -exec epstopdf {} ";" ;
find -E $INC -type f -name "*.eps" -exec rm -f {} \;

# Копирование файлов из папки img
cd $INC
if [[ $(ls) ]]; then
    cp -r * ../$TEX
fi
cd ..

# Сборка latex
cd tex
$PDFLATEX $MAINTEX | $GREP
BIBOUTPUT=$(bibtex $MAINTEX)
# Показывать output bibtex'a только в случае ошибок
if [[ "$BIBOUTPUT" =~ "error" ]]; then
    echo "$BIBOUTPUT"
fi
$PDFLATEX $MAINTEX | $GREP
cp $MAINTEX.pdf ../$PDF_NAME
cd ..

# Clear
find -E $TEX/ -type f ! -regex ".*\.(tex|bib|gitignore)" -exec rm -f {} \; ;
# find -E $TEX/ -type d -exec rm -rf {} \;



# Pdflatex
PDFLATEX='pdflatex -interaction=nonstopmode -shell-escape -file-line-error'
GREP='grep ".*:[0-9]*:.*"' # показывает на выходе только ошибки

# Файлы/Папки
PDF_NAME='thesis.pdf'
TEX='tex'
IMG='tex/inc/img'
MAINTEX='0-main'

# Конвертация eps
find -E $IMG/ -type f -name "*.eps" -exec epstopdf {} ";" ;
find -E $IMG -type f -name "*.eps" -exec rm -f {} \;

# Сборка latex
cd tex
$PDFLATEX $MAINTEX
BIBOUTPUT=$(bibtex $MAINTEX)
# Показывать output bibtex'a только в случае ошибок
if [[ "$BIBOUTPUT" =~ "error" ]]; then
    echo "$BIBOUTPUT"
fi
$PDFLATEX $MAINTEX
cp $MAINTEX.pdf ../$PDF_NAME
cd ..

# Clear
find -E $TEX/ -maxdepth 1 -type f ! -regex ".*\.(tex|bib|cls|sty|bst|clo|asm|gitignore)" -exec rm -f {} \; ;



# dotfiles
Для организации и хранения конфигов используется метод  **git bare** репозитория. За основу взята статья: https://www.atlassian.com/git/tutorials/dotfiles

# Как использовать
Чтобы развернуть конфиг в новой системе необходимо:
- клонировать репозиторий
```bash
git clone --bare https://github.com/FactoREAL/dotfiles.git $HOME/dotfiles
```
- добавить алиас для командной оболочки _(.bashrc, .zshrc)_ ```alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'```
- получить актуальные данные из репозитория 
```bash
dotfiles checkout
```
- сконфигурировать репозиторий так, чтобы git не отображал те файлы, которые он не отслеживает
```bash
dotfiles config --local status.showUntrackedFiles no
```

Вся дальнейшая работа происходит как с обычным git репозиторием. Главное не забывать использовать в командах соответствующий алиас **dotfiles** вместо git

### возможные проблемы
Если в системе уже имеются соответствующие файлы из репозитория, то появится следующая ошибка **error: The following untracked working tree files would be overwritten by checkout:
    .bashrc
    .gitignore
Please move or remove them before you can switch branches.
Aborting**.

Для решения можно использовать следующий скрипт:
```bash
mkdir -p dotfiles-backup && \
dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} dotfiles-backup/{}
```
он предварительно сделает бекап конфликтующих файлов в отдельной директории. При наличии вложенности копируемых файлов могут возникнуть ошибки при создании бекапа.
В таком случае можно руками перенести проблемные файлы. После успешного создания резервной копии файлов нужно повторно пополнить команду ```dotfiles checkout```

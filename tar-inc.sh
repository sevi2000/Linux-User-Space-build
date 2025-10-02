#!/bin/sh

# Restore during stage 1 on your PC (pwd is stage1): ../tar-inc.sh extract upc 14-014_grep
# Restore during stage 2 or base on the board outside of chroot (pwd is stage2 or base): ../tar-inc.sh extract /mnt 27-026_bison

# Can be used on your PC for stage 1 (create and extract). For stage 2 on the board, create is inside of chroot and extract is outside of chroot.

# On creation, label = 001_binutils. On extraction, label = 1-001_binutils.

# Test: rm -r Xx Xx-inc; mkdir Xx; echo a > Xx/a; ./tar-inc.sh create Xx a; echo b > Xx/b; ./tar-inc.sh create Xx b; ./tar-inc.sh extract Xx 0-a; echo b > Xx/b; ./tar-inc.sh create Xx b

set -u -e

script_name=${0##*/}
script_fullpath=$(realpath "$0")

IFS='
'

action=$1
dir_to_backup=$2
label=$3
# Evade set -u
create_after_extract=${4+"$4"}

[ "$action" ]
[ "$dir_to_backup" ]
[ "$label" ]

dir_to_backup_fullpath=$(realpath "$dir_to_backup")
dir_to_backup_basename=$(basename -- "$dir_to_backup_fullpath") # We need realpath beforehand because $dir_to_backup could be '.' etc
[ "$dir_to_backup_basename" = / ] && backups_dir=mnt-inc || backups_dir=$dir_to_backup_basename-inc

mkdir -pv -- "$dir_to_backup" "$backups_dir" >&2 # Shouldn't change mtime ctime atime

backups_dir_fullpath=$(realpath "$backups_dir")

old_pwd=$PWD
cd "$dir_to_backup_fullpath"

fullpaths_to_exclude=$backups_dir_fullpath'
'
if [ "$dir_to_backup_fullpath" = /mnt ] || [ "$dir_to_backup_fullpath" = / ]; then
    prefix=${dir_to_backup_fullpath%/}/
    for i in dev proc sys run unix-2023 sources lost+found tmp; do
        fullpaths_to_exclude=$fullpaths_to_exclude$prefix$i'
'
    done
fi

if [ "$action" = create ]; then # create won't work on BusyBox because tar's --listed-incremental and --format don't exist
    next_number=$(( $(find "$backups_dir_fullpath" -mindepth 1 -maxdepth 1 | wc -l) / 2 ))
    last_number=$((next_number - 1))

    next_backup_fullpath_prefix=$backups_dir_fullpath/$next_number-$label
    last_backup_fullpath_prefix=$backups_dir_fullpath/$last_number

    if ! [ "$create_after_extract" ]; then
        cp -fv -- "$last_backup_fullpath_prefix"-*.snar "$next_backup_fullpath_prefix".snar 1>&2 2>/dev/null || true
    fi

    excludes=
    for i in $fullpaths_to_exclude; do
        tmp=${i#"$dir_to_backup_fullpath"}
        tmp=${tmp#/}
        excludes=$excludes--exclude=./$tmp'
'
    done

    [ "$create_after_extract" ] && dest=/dev/null || dest=$next_backup_fullpath_prefix.tar

    set -f
    tar --format=posix -cvf "$dest" --listed-incremental="$next_backup_fullpath_prefix.snar" $excludes . 2>&1 | sed "s/^/$script_name $label $action: /" >&2 # You must pass . and not $(find . -mindepth 1 -maxdepth 1 -printf '%P\n')
    set +f

    [ "$create_after_extract" ] || printf '%s\n' "$next_backup_fullpath_prefix.tar"
elif [ "$action" = extract ]; then
    restore_up_to=$backups_dir_fullpath/$label.tar

    [ -f "$restore_up_to" ] || {
        echo "Backup '$restore_up_to' doesn't exist, extract label should be of form 1-001_binutils" >&2
        exit 1
    }

    printf "Type 'y' to delete '%s' before restoring it from backup (chroot.sh directories will be preserved): " "$dir_to_backup"
    read -r answer
    [ "$answer" = y ]

    files_to_delete=$(find "$dir_to_backup_fullpath"/ -mindepth 1)

    for i in $fullpaths_to_exclude; do
        files_to_delete=$(printf '%s\n' "$files_to_delete" | grep -Fv -- "$i" || true)
    done
    #files_to_delete=$(printf '%s\n' "$files_to_delete" | grep -Fv -- "$fullpaths_to_exclude" || true) # Doesn't work

    for i in $files_to_delete; do
        rm -rvf -- "$i" 2>&1 | sed "s/^/$script_name $label $action rm: /" >&2
    done

    for i in $(find "$backups_dir_fullpath"/ -mindepth 1 -maxdepth 1 -name '*.tar' | sort -V | grep -FxB2000000000 -- "$restore_up_to"); do
        tar -vxf "$i" 2>&1 | sed "s/^/$script_name $label $action tar -x: /" >&2
    done

    rm -rvf "$backups_dir_fullpath"-old
    cp -rl "$backups_dir_fullpath" "$backups_dir_fullpath"-old
    tars_to_delete=$(find "$backups_dir_fullpath"/ -mindepth 1 -maxdepth 1 -name '*.tar' | sort -V | grep -FxA2000000000 -- "$restore_up_to" | sed 1d)
    snars_to_delete=$(printf '%s\n' "$tars_to_delete" | sed 's/\.tar$/.snar/')

    for i in $tars_to_delete $snars_to_delete; do
        rm -rvf -- "$i" >&2
    done

    # Fix "after restore of backup n, performing step n + 1 leads to an n + 1 backup that contains every file ever"
    rm -vf -- "${restore_up_to%tar}snar"

    if [ -e /mnt/time.txt ] && [ "$dir_to_backup_fullpath" = /mnt ]; then
        /mnt/unix-2023/chroot-run-cmd.sh /bin/bash -c 'cd "$1"; /unix-2023/tar-inc.sh create / "$2" create_after_extract' bash "${old_pwd#/mnt}" "${label#*-}"
    else
        cd "$old_pwd"
        "$script_fullpath" create "$dir_to_backup_fullpath" "${label#*-}" create_after_extract
    fi
fi

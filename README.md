Uses [Coldsnap](https://github.com/awslabs/coldsnap) to download from list of snapshots, and scans them media. Filters out known [DEA Notebook files](https://github.com/GeoscienceAustralia/dea-notebooks).

```bash
$ ./generate_dea_notebook_hashes.sh
Cloning into '/tmp/tmp.CgO4kAQeV6/dea-notebooks'...
remote: Enumerating objects: 23586, done.
remote: Counting objects: 100% (163/163), done.
remote: Compressing objects: 100% (67/67), done.
remote: Total 23586 (delta 126), reused 108 (delta 96), pack-reused 23423 (from 3)
Receiving objects: 100% (23586/23586), 3.29 GiB | 20.70 MiB/s, done.
Resolving deltas: 100% (13573/13573), done.
Checking out files: 100% (247/247), done.

$ head dea_notebook_file_hashes.txt
0012b5e7725138b3392a25d8cf33dade50580704
0022462988971cb6d04116abfe2fc11f8a48e7f4
002631cc63e7d204d07cca9ed2b997cd30306c18
00282b71f237545edadcadfca7f9a02982001282
002af602b6479ba5dc7657ec349a7eb8205e3f34
003ee389e7e1ccc22d23b3aedbf2a7b4ebf57e87
004e23e35b88ac292c02bd3b6bf32cadf81a420d
004f302dd50a0eb41d281978ccc19068981494df
0057a441f56d267db520b64f03041b9c87e04066
0063ca026bc22d5d50cc84f3320604c7a9a22400
```

```bash
$ echo 'snap-014ae3c3ff73da94a
snap-034e6f7572abdd155' > snapshot_ids.txt
```

```
$ ./scan_snapshots.sh snapshot_ids.txt dea_notebook_file_hashes.txt
Processing snapshot: snap-014ae3c3ff73da94a
find: ‘snap-014ae3c3ff73da94a-mount/lost+found’: Permission denied
Cleaning up...
Processing snapshot: snap-034e6f7572abdd155
find: ‘snap-034e6f7572abdd155-mount/lost+found’: Permission denied
Cleaning up...

$ ls snap-*
snap-014ae3c3ff73da94a-files.txt  snap-014ae3c3ff73da94a-media.txt  snap-034e6f7572abdd155-files.txt  snap-034e6f7572abdd155-media.txt

```

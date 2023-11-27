
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	56                   	push   %esi
   4:	53                   	push   %ebx
   5:	83 ec 10             	sub    $0x10,%esp
   8:	e8 84 03 00 00       	call   391 <__x86.get_pc_thunk.bx>
   d:	81 c3 3b 0f 00 00    	add    $0xf3b,%ebx
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  13:	83 ec 0c             	sub    $0xc,%esp
  16:	ff 75 08             	push   0x8(%ebp)
  19:	e8 2a 04 00 00       	call   448 <strlen>
  1e:	83 c4 10             	add    $0x10,%esp
  21:	8b 55 08             	mov    0x8(%ebp),%edx
  24:	01 d0                	add    %edx,%eax
  26:	89 45 f4             	mov    %eax,-0xc(%ebp)
  29:	eb 04                	jmp    2f <fmtname+0x2f>
  2b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  32:	3b 45 08             	cmp    0x8(%ebp),%eax
  35:	72 0a                	jb     41 <fmtname+0x41>
  37:	8b 45 f4             	mov    -0xc(%ebp),%eax
  3a:	0f b6 00             	movzbl (%eax),%eax
  3d:	3c 2f                	cmp    $0x2f,%al
  3f:	75 ea                	jne    2b <fmtname+0x2b>
    ;
  p++;
  41:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  45:	83 ec 0c             	sub    $0xc,%esp
  48:	ff 75 f4             	push   -0xc(%ebp)
  4b:	e8 f8 03 00 00       	call   448 <strlen>
  50:	83 c4 10             	add    $0x10,%esp
  53:	83 f8 0d             	cmp    $0xd,%eax
  56:	76 05                	jbe    5d <fmtname+0x5d>
    return p;
  58:	8b 45 f4             	mov    -0xc(%ebp),%eax
  5b:	eb 66                	jmp    c3 <fmtname+0xc3>
  memmove(buf, p, strlen(p));
  5d:	83 ec 0c             	sub    $0xc,%esp
  60:	ff 75 f4             	push   -0xc(%ebp)
  63:	e8 e0 03 00 00       	call   448 <strlen>
  68:	83 c4 10             	add    $0x10,%esp
  6b:	83 ec 04             	sub    $0x4,%esp
  6e:	50                   	push   %eax
  6f:	ff 75 f4             	push   -0xc(%ebp)
  72:	8d 83 20 00 00 00    	lea    0x20(%ebx),%eax
  78:	50                   	push   %eax
  79:	e8 8d 05 00 00       	call   60b <memmove>
  7e:	83 c4 10             	add    $0x10,%esp
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  81:	83 ec 0c             	sub    $0xc,%esp
  84:	ff 75 f4             	push   -0xc(%ebp)
  87:	e8 bc 03 00 00       	call   448 <strlen>
  8c:	83 c4 10             	add    $0x10,%esp
  8f:	ba 0e 00 00 00       	mov    $0xe,%edx
  94:	89 d6                	mov    %edx,%esi
  96:	29 c6                	sub    %eax,%esi
  98:	83 ec 0c             	sub    $0xc,%esp
  9b:	ff 75 f4             	push   -0xc(%ebp)
  9e:	e8 a5 03 00 00       	call   448 <strlen>
  a3:	83 c4 10             	add    $0x10,%esp
  a6:	8d 93 20 00 00 00    	lea    0x20(%ebx),%edx
  ac:	01 d0                	add    %edx,%eax
  ae:	83 ec 04             	sub    $0x4,%esp
  b1:	56                   	push   %esi
  b2:	6a 20                	push   $0x20
  b4:	50                   	push   %eax
  b5:	e8 bf 03 00 00       	call   479 <memset>
  ba:	83 c4 10             	add    $0x10,%esp
  return buf;
  bd:	8d 83 20 00 00 00    	lea    0x20(%ebx),%eax
}
  c3:	8d 65 f8             	lea    -0x8(%ebp),%esp
  c6:	5b                   	pop    %ebx
  c7:	5e                   	pop    %esi
  c8:	5d                   	pop    %ebp
  c9:	c3                   	ret    

000000ca <ls>:

void
ls(char *path)
{
  ca:	55                   	push   %ebp
  cb:	89 e5                	mov    %esp,%ebp
  cd:	57                   	push   %edi
  ce:	56                   	push   %esi
  cf:	53                   	push   %ebx
  d0:	81 ec 4c 02 00 00    	sub    $0x24c,%esp
  d6:	e8 b6 02 00 00       	call   391 <__x86.get_pc_thunk.bx>
  db:	81 c3 6d 0e 00 00    	add    $0xe6d,%ebx
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
  e1:	83 ec 08             	sub    $0x8,%esp
  e4:	6a 00                	push   $0x0
  e6:	ff 75 08             	push   0x8(%ebp)
  e9:	e8 b0 05 00 00       	call   69e <open>
  ee:	83 c4 10             	add    $0x10,%esp
  f1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  f4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  f8:	79 1c                	jns    116 <ls+0x4c>
    printf(2, "ls: cannot open %s\n", path);
  fa:	83 ec 04             	sub    $0x4,%esp
  fd:	ff 75 08             	push   0x8(%ebp)
 100:	8d 83 b1 fc ff ff    	lea    -0x34f(%ebx),%eax
 106:	50                   	push   %eax
 107:	6a 02                	push   $0x2
 109:	e8 ec 06 00 00       	call   7fa <printf>
 10e:	83 c4 10             	add    $0x10,%esp
    return;
 111:	e9 01 02 00 00       	jmp    317 <ls+0x24d>
  }

  if(fstat(fd, &st) < 0){
 116:	83 ec 08             	sub    $0x8,%esp
 119:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
 11f:	50                   	push   %eax
 120:	ff 75 e4             	push   -0x1c(%ebp)
 123:	e8 8e 05 00 00       	call   6b6 <fstat>
 128:	83 c4 10             	add    $0x10,%esp
 12b:	85 c0                	test   %eax,%eax
 12d:	79 2a                	jns    159 <ls+0x8f>
    printf(2, "ls: cannot stat %s\n", path);
 12f:	83 ec 04             	sub    $0x4,%esp
 132:	ff 75 08             	push   0x8(%ebp)
 135:	8d 83 c5 fc ff ff    	lea    -0x33b(%ebx),%eax
 13b:	50                   	push   %eax
 13c:	6a 02                	push   $0x2
 13e:	e8 b7 06 00 00       	call   7fa <printf>
 143:	83 c4 10             	add    $0x10,%esp
    close(fd);
 146:	83 ec 0c             	sub    $0xc,%esp
 149:	ff 75 e4             	push   -0x1c(%ebp)
 14c:	e8 35 05 00 00       	call   686 <close>
 151:	83 c4 10             	add    $0x10,%esp
    return;
 154:	e9 be 01 00 00       	jmp    317 <ls+0x24d>
  }

  switch(st.type){
 159:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
 160:	98                   	cwtl   
 161:	83 f8 01             	cmp    $0x1,%eax
 164:	74 55                	je     1bb <ls+0xf1>
 166:	83 f8 02             	cmp    $0x2,%eax
 169:	0f 85 9a 01 00 00    	jne    309 <ls+0x23f>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 16f:	8b 85 cc fd ff ff    	mov    -0x234(%ebp),%eax
 175:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 17b:	8b bd c4 fd ff ff    	mov    -0x23c(%ebp),%edi
 181:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
 188:	0f bf f0             	movswl %ax,%esi
 18b:	83 ec 0c             	sub    $0xc,%esp
 18e:	ff 75 08             	push   0x8(%ebp)
 191:	e8 6a fe ff ff       	call   0 <fmtname>
 196:	83 c4 10             	add    $0x10,%esp
 199:	83 ec 08             	sub    $0x8,%esp
 19c:	ff b5 b4 fd ff ff    	push   -0x24c(%ebp)
 1a2:	57                   	push   %edi
 1a3:	56                   	push   %esi
 1a4:	50                   	push   %eax
 1a5:	8d 83 d9 fc ff ff    	lea    -0x327(%ebx),%eax
 1ab:	50                   	push   %eax
 1ac:	6a 01                	push   $0x1
 1ae:	e8 47 06 00 00       	call   7fa <printf>
 1b3:	83 c4 20             	add    $0x20,%esp
    break;
 1b6:	e9 4e 01 00 00       	jmp    309 <ls+0x23f>

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 1bb:	83 ec 0c             	sub    $0xc,%esp
 1be:	ff 75 08             	push   0x8(%ebp)
 1c1:	e8 82 02 00 00       	call   448 <strlen>
 1c6:	83 c4 10             	add    $0x10,%esp
 1c9:	83 c0 10             	add    $0x10,%eax
 1cc:	3d 00 02 00 00       	cmp    $0x200,%eax
 1d1:	76 19                	jbe    1ec <ls+0x122>
      printf(1, "ls: path too long\n");
 1d3:	83 ec 08             	sub    $0x8,%esp
 1d6:	8d 83 e6 fc ff ff    	lea    -0x31a(%ebx),%eax
 1dc:	50                   	push   %eax
 1dd:	6a 01                	push   $0x1
 1df:	e8 16 06 00 00       	call   7fa <printf>
 1e4:	83 c4 10             	add    $0x10,%esp
      break;
 1e7:	e9 1d 01 00 00       	jmp    309 <ls+0x23f>
    }
    strcpy(buf, path);
 1ec:	83 ec 08             	sub    $0x8,%esp
 1ef:	ff 75 08             	push   0x8(%ebp)
 1f2:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 1f8:	50                   	push   %eax
 1f9:	e8 c7 01 00 00       	call   3c5 <strcpy>
 1fe:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
 201:	83 ec 0c             	sub    $0xc,%esp
 204:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 20a:	50                   	push   %eax
 20b:	e8 38 02 00 00       	call   448 <strlen>
 210:	83 c4 10             	add    $0x10,%esp
 213:	8d 95 e0 fd ff ff    	lea    -0x220(%ebp),%edx
 219:	01 d0                	add    %edx,%eax
 21b:	89 45 e0             	mov    %eax,-0x20(%ebp)
    *p++ = '/';
 21e:	8b 45 e0             	mov    -0x20(%ebp),%eax
 221:	8d 50 01             	lea    0x1(%eax),%edx
 224:	89 55 e0             	mov    %edx,-0x20(%ebp)
 227:	c6 00 2f             	movb   $0x2f,(%eax)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 22a:	e9 b9 00 00 00       	jmp    2e8 <ls+0x21e>
      if(de.inum == 0)
 22f:	0f b7 85 d0 fd ff ff 	movzwl -0x230(%ebp),%eax
 236:	66 85 c0             	test   %ax,%ax
 239:	75 05                	jne    240 <ls+0x176>
        continue;
 23b:	e9 a8 00 00 00       	jmp    2e8 <ls+0x21e>
      memmove(p, de.name, DIRSIZ);
 240:	83 ec 04             	sub    $0x4,%esp
 243:	6a 0e                	push   $0xe
 245:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
 24b:	83 c0 02             	add    $0x2,%eax
 24e:	50                   	push   %eax
 24f:	ff 75 e0             	push   -0x20(%ebp)
 252:	e8 b4 03 00 00       	call   60b <memmove>
 257:	83 c4 10             	add    $0x10,%esp
      p[DIRSIZ] = 0;
 25a:	8b 45 e0             	mov    -0x20(%ebp),%eax
 25d:	83 c0 0e             	add    $0xe,%eax
 260:	c6 00 00             	movb   $0x0,(%eax)
      if(stat(buf, &st) < 0){
 263:	83 ec 08             	sub    $0x8,%esp
 266:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
 26c:	50                   	push   %eax
 26d:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 273:	50                   	push   %eax
 274:	e8 df 02 00 00       	call   558 <stat>
 279:	83 c4 10             	add    $0x10,%esp
 27c:	85 c0                	test   %eax,%eax
 27e:	79 1d                	jns    29d <ls+0x1d3>
        printf(1, "ls: cannot stat %s\n", buf);
 280:	83 ec 04             	sub    $0x4,%esp
 283:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 289:	50                   	push   %eax
 28a:	8d 83 c5 fc ff ff    	lea    -0x33b(%ebx),%eax
 290:	50                   	push   %eax
 291:	6a 01                	push   $0x1
 293:	e8 62 05 00 00       	call   7fa <printf>
 298:	83 c4 10             	add    $0x10,%esp
        continue;
 29b:	eb 4b                	jmp    2e8 <ls+0x21e>
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 29d:	8b 85 cc fd ff ff    	mov    -0x234(%ebp),%eax
 2a3:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 2a9:	8b bd c4 fd ff ff    	mov    -0x23c(%ebp),%edi
 2af:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
 2b6:	0f bf f0             	movswl %ax,%esi
 2b9:	83 ec 0c             	sub    $0xc,%esp
 2bc:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 2c2:	50                   	push   %eax
 2c3:	e8 38 fd ff ff       	call   0 <fmtname>
 2c8:	83 c4 10             	add    $0x10,%esp
 2cb:	83 ec 08             	sub    $0x8,%esp
 2ce:	ff b5 b4 fd ff ff    	push   -0x24c(%ebp)
 2d4:	57                   	push   %edi
 2d5:	56                   	push   %esi
 2d6:	50                   	push   %eax
 2d7:	8d 83 d9 fc ff ff    	lea    -0x327(%ebx),%eax
 2dd:	50                   	push   %eax
 2de:	6a 01                	push   $0x1
 2e0:	e8 15 05 00 00       	call   7fa <printf>
 2e5:	83 c4 20             	add    $0x20,%esp
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 2e8:	83 ec 04             	sub    $0x4,%esp
 2eb:	6a 10                	push   $0x10
 2ed:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
 2f3:	50                   	push   %eax
 2f4:	ff 75 e4             	push   -0x1c(%ebp)
 2f7:	e8 7a 03 00 00       	call   676 <read>
 2fc:	83 c4 10             	add    $0x10,%esp
 2ff:	83 f8 10             	cmp    $0x10,%eax
 302:	0f 84 27 ff ff ff    	je     22f <ls+0x165>
    }
    break;
 308:	90                   	nop
  }
  close(fd);
 309:	83 ec 0c             	sub    $0xc,%esp
 30c:	ff 75 e4             	push   -0x1c(%ebp)
 30f:	e8 72 03 00 00       	call   686 <close>
 314:	83 c4 10             	add    $0x10,%esp
}
 317:	8d 65 f4             	lea    -0xc(%ebp),%esp
 31a:	5b                   	pop    %ebx
 31b:	5e                   	pop    %esi
 31c:	5f                   	pop    %edi
 31d:	5d                   	pop    %ebp
 31e:	c3                   	ret    

0000031f <main>:

int
main(int argc, char *argv[])
{
 31f:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 323:	83 e4 f0             	and    $0xfffffff0,%esp
 326:	ff 71 fc             	push   -0x4(%ecx)
 329:	55                   	push   %ebp
 32a:	89 e5                	mov    %esp,%ebp
 32c:	56                   	push   %esi
 32d:	53                   	push   %ebx
 32e:	51                   	push   %ecx
 32f:	83 ec 1c             	sub    $0x1c,%esp
 332:	e8 5a 00 00 00       	call   391 <__x86.get_pc_thunk.bx>
 337:	81 c3 11 0c 00 00    	add    $0xc11,%ebx
 33d:	89 ce                	mov    %ecx,%esi
  int i;

  if(argc < 2){
 33f:	83 3e 01             	cmpl   $0x1,(%esi)
 342:	7f 17                	jg     35b <main+0x3c>
    ls(".");
 344:	83 ec 0c             	sub    $0xc,%esp
 347:	8d 83 f9 fc ff ff    	lea    -0x307(%ebx),%eax
 34d:	50                   	push   %eax
 34e:	e8 77 fd ff ff       	call   ca <ls>
 353:	83 c4 10             	add    $0x10,%esp
    exit();
 356:	e8 03 03 00 00       	call   65e <exit>
  }
  for(i=1; i<argc; i++)
 35b:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
 362:	eb 21                	jmp    385 <main+0x66>
    ls(argv[i]);
 364:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 367:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 36e:	8b 46 04             	mov    0x4(%esi),%eax
 371:	01 d0                	add    %edx,%eax
 373:	8b 00                	mov    (%eax),%eax
 375:	83 ec 0c             	sub    $0xc,%esp
 378:	50                   	push   %eax
 379:	e8 4c fd ff ff       	call   ca <ls>
 37e:	83 c4 10             	add    $0x10,%esp
  for(i=1; i<argc; i++)
 381:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
 385:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 388:	3b 06                	cmp    (%esi),%eax
 38a:	7c d8                	jl     364 <main+0x45>
  exit();
 38c:	e8 cd 02 00 00       	call   65e <exit>

00000391 <__x86.get_pc_thunk.bx>:
 391:	8b 1c 24             	mov    (%esp),%ebx
 394:	c3                   	ret    

00000395 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 395:	55                   	push   %ebp
 396:	89 e5                	mov    %esp,%ebp
 398:	57                   	push   %edi
 399:	53                   	push   %ebx
 39a:	e8 b3 02 00 00       	call   652 <__x86.get_pc_thunk.ax>
 39f:	05 a9 0b 00 00       	add    $0xba9,%eax
  asm volatile("cld; rep stosb" :
 3a4:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3a7:	8b 55 10             	mov    0x10(%ebp),%edx
 3aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ad:	89 cb                	mov    %ecx,%ebx
 3af:	89 df                	mov    %ebx,%edi
 3b1:	89 d1                	mov    %edx,%ecx
 3b3:	fc                   	cld    
 3b4:	f3 aa                	rep stos %al,%es:(%edi)
 3b6:	89 ca                	mov    %ecx,%edx
 3b8:	89 fb                	mov    %edi,%ebx
 3ba:	89 5d 08             	mov    %ebx,0x8(%ebp)
 3bd:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 3c0:	90                   	nop
 3c1:	5b                   	pop    %ebx
 3c2:	5f                   	pop    %edi
 3c3:	5d                   	pop    %ebp
 3c4:	c3                   	ret    

000003c5 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 3c5:	55                   	push   %ebp
 3c6:	89 e5                	mov    %esp,%ebp
 3c8:	83 ec 10             	sub    $0x10,%esp
 3cb:	e8 82 02 00 00       	call   652 <__x86.get_pc_thunk.ax>
 3d0:	05 78 0b 00 00       	add    $0xb78,%eax
  char *os;

  os = s;
 3d5:	8b 45 08             	mov    0x8(%ebp),%eax
 3d8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 3db:	90                   	nop
 3dc:	8b 55 0c             	mov    0xc(%ebp),%edx
 3df:	8d 42 01             	lea    0x1(%edx),%eax
 3e2:	89 45 0c             	mov    %eax,0xc(%ebp)
 3e5:	8b 45 08             	mov    0x8(%ebp),%eax
 3e8:	8d 48 01             	lea    0x1(%eax),%ecx
 3eb:	89 4d 08             	mov    %ecx,0x8(%ebp)
 3ee:	0f b6 12             	movzbl (%edx),%edx
 3f1:	88 10                	mov    %dl,(%eax)
 3f3:	0f b6 00             	movzbl (%eax),%eax
 3f6:	84 c0                	test   %al,%al
 3f8:	75 e2                	jne    3dc <strcpy+0x17>
    ;
  return os;
 3fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3fd:	c9                   	leave  
 3fe:	c3                   	ret    

000003ff <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3ff:	55                   	push   %ebp
 400:	89 e5                	mov    %esp,%ebp
 402:	e8 4b 02 00 00       	call   652 <__x86.get_pc_thunk.ax>
 407:	05 41 0b 00 00       	add    $0xb41,%eax
  while(*p && *p == *q)
 40c:	eb 08                	jmp    416 <strcmp+0x17>
    p++, q++;
 40e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 412:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 416:	8b 45 08             	mov    0x8(%ebp),%eax
 419:	0f b6 00             	movzbl (%eax),%eax
 41c:	84 c0                	test   %al,%al
 41e:	74 10                	je     430 <strcmp+0x31>
 420:	8b 45 08             	mov    0x8(%ebp),%eax
 423:	0f b6 10             	movzbl (%eax),%edx
 426:	8b 45 0c             	mov    0xc(%ebp),%eax
 429:	0f b6 00             	movzbl (%eax),%eax
 42c:	38 c2                	cmp    %al,%dl
 42e:	74 de                	je     40e <strcmp+0xf>
  return (uchar)*p - (uchar)*q;
 430:	8b 45 08             	mov    0x8(%ebp),%eax
 433:	0f b6 00             	movzbl (%eax),%eax
 436:	0f b6 d0             	movzbl %al,%edx
 439:	8b 45 0c             	mov    0xc(%ebp),%eax
 43c:	0f b6 00             	movzbl (%eax),%eax
 43f:	0f b6 c8             	movzbl %al,%ecx
 442:	89 d0                	mov    %edx,%eax
 444:	29 c8                	sub    %ecx,%eax
}
 446:	5d                   	pop    %ebp
 447:	c3                   	ret    

00000448 <strlen>:

uint
strlen(const char *s)
{
 448:	55                   	push   %ebp
 449:	89 e5                	mov    %esp,%ebp
 44b:	83 ec 10             	sub    $0x10,%esp
 44e:	e8 ff 01 00 00       	call   652 <__x86.get_pc_thunk.ax>
 453:	05 f5 0a 00 00       	add    $0xaf5,%eax
  int n;

  for(n = 0; s[n]; n++)
 458:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 45f:	eb 04                	jmp    465 <strlen+0x1d>
 461:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 465:	8b 55 fc             	mov    -0x4(%ebp),%edx
 468:	8b 45 08             	mov    0x8(%ebp),%eax
 46b:	01 d0                	add    %edx,%eax
 46d:	0f b6 00             	movzbl (%eax),%eax
 470:	84 c0                	test   %al,%al
 472:	75 ed                	jne    461 <strlen+0x19>
    ;
  return n;
 474:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 477:	c9                   	leave  
 478:	c3                   	ret    

00000479 <memset>:

void*
memset(void *dst, int c, uint n)
{
 479:	55                   	push   %ebp
 47a:	89 e5                	mov    %esp,%ebp
 47c:	e8 d1 01 00 00       	call   652 <__x86.get_pc_thunk.ax>
 481:	05 c7 0a 00 00       	add    $0xac7,%eax
  stosb(dst, c, n);
 486:	8b 45 10             	mov    0x10(%ebp),%eax
 489:	50                   	push   %eax
 48a:	ff 75 0c             	push   0xc(%ebp)
 48d:	ff 75 08             	push   0x8(%ebp)
 490:	e8 00 ff ff ff       	call   395 <stosb>
 495:	83 c4 0c             	add    $0xc,%esp
  return dst;
 498:	8b 45 08             	mov    0x8(%ebp),%eax
}
 49b:	c9                   	leave  
 49c:	c3                   	ret    

0000049d <strchr>:

char*
strchr(const char *s, char c)
{
 49d:	55                   	push   %ebp
 49e:	89 e5                	mov    %esp,%ebp
 4a0:	83 ec 04             	sub    $0x4,%esp
 4a3:	e8 aa 01 00 00       	call   652 <__x86.get_pc_thunk.ax>
 4a8:	05 a0 0a 00 00       	add    $0xaa0,%eax
 4ad:	8b 45 0c             	mov    0xc(%ebp),%eax
 4b0:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 4b3:	eb 14                	jmp    4c9 <strchr+0x2c>
    if(*s == c)
 4b5:	8b 45 08             	mov    0x8(%ebp),%eax
 4b8:	0f b6 00             	movzbl (%eax),%eax
 4bb:	38 45 fc             	cmp    %al,-0x4(%ebp)
 4be:	75 05                	jne    4c5 <strchr+0x28>
      return (char*)s;
 4c0:	8b 45 08             	mov    0x8(%ebp),%eax
 4c3:	eb 13                	jmp    4d8 <strchr+0x3b>
  for(; *s; s++)
 4c5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 4c9:	8b 45 08             	mov    0x8(%ebp),%eax
 4cc:	0f b6 00             	movzbl (%eax),%eax
 4cf:	84 c0                	test   %al,%al
 4d1:	75 e2                	jne    4b5 <strchr+0x18>
  return 0;
 4d3:	b8 00 00 00 00       	mov    $0x0,%eax
}
 4d8:	c9                   	leave  
 4d9:	c3                   	ret    

000004da <gets>:

char*
gets(char *buf, int max)
{
 4da:	55                   	push   %ebp
 4db:	89 e5                	mov    %esp,%ebp
 4dd:	53                   	push   %ebx
 4de:	83 ec 14             	sub    $0x14,%esp
 4e1:	e8 ab fe ff ff       	call   391 <__x86.get_pc_thunk.bx>
 4e6:	81 c3 62 0a 00 00    	add    $0xa62,%ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4ec:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 4f3:	eb 42                	jmp    537 <gets+0x5d>
    cc = read(0, &c, 1);
 4f5:	83 ec 04             	sub    $0x4,%esp
 4f8:	6a 01                	push   $0x1
 4fa:	8d 45 ef             	lea    -0x11(%ebp),%eax
 4fd:	50                   	push   %eax
 4fe:	6a 00                	push   $0x0
 500:	e8 71 01 00 00       	call   676 <read>
 505:	83 c4 10             	add    $0x10,%esp
 508:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 50b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 50f:	7e 33                	jle    544 <gets+0x6a>
      break;
    buf[i++] = c;
 511:	8b 45 f4             	mov    -0xc(%ebp),%eax
 514:	8d 50 01             	lea    0x1(%eax),%edx
 517:	89 55 f4             	mov    %edx,-0xc(%ebp)
 51a:	89 c2                	mov    %eax,%edx
 51c:	8b 45 08             	mov    0x8(%ebp),%eax
 51f:	01 c2                	add    %eax,%edx
 521:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 525:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 527:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 52b:	3c 0a                	cmp    $0xa,%al
 52d:	74 16                	je     545 <gets+0x6b>
 52f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 533:	3c 0d                	cmp    $0xd,%al
 535:	74 0e                	je     545 <gets+0x6b>
  for(i=0; i+1 < max; ){
 537:	8b 45 f4             	mov    -0xc(%ebp),%eax
 53a:	83 c0 01             	add    $0x1,%eax
 53d:	39 45 0c             	cmp    %eax,0xc(%ebp)
 540:	7f b3                	jg     4f5 <gets+0x1b>
 542:	eb 01                	jmp    545 <gets+0x6b>
      break;
 544:	90                   	nop
      break;
  }
  buf[i] = '\0';
 545:	8b 55 f4             	mov    -0xc(%ebp),%edx
 548:	8b 45 08             	mov    0x8(%ebp),%eax
 54b:	01 d0                	add    %edx,%eax
 54d:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 550:	8b 45 08             	mov    0x8(%ebp),%eax
}
 553:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 556:	c9                   	leave  
 557:	c3                   	ret    

00000558 <stat>:

int
stat(const char *n, struct stat *st)
{
 558:	55                   	push   %ebp
 559:	89 e5                	mov    %esp,%ebp
 55b:	53                   	push   %ebx
 55c:	83 ec 14             	sub    $0x14,%esp
 55f:	e8 2d fe ff ff       	call   391 <__x86.get_pc_thunk.bx>
 564:	81 c3 e4 09 00 00    	add    $0x9e4,%ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 56a:	83 ec 08             	sub    $0x8,%esp
 56d:	6a 00                	push   $0x0
 56f:	ff 75 08             	push   0x8(%ebp)
 572:	e8 27 01 00 00       	call   69e <open>
 577:	83 c4 10             	add    $0x10,%esp
 57a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 57d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 581:	79 07                	jns    58a <stat+0x32>
    return -1;
 583:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 588:	eb 25                	jmp    5af <stat+0x57>
  r = fstat(fd, st);
 58a:	83 ec 08             	sub    $0x8,%esp
 58d:	ff 75 0c             	push   0xc(%ebp)
 590:	ff 75 f4             	push   -0xc(%ebp)
 593:	e8 1e 01 00 00       	call   6b6 <fstat>
 598:	83 c4 10             	add    $0x10,%esp
 59b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 59e:	83 ec 0c             	sub    $0xc,%esp
 5a1:	ff 75 f4             	push   -0xc(%ebp)
 5a4:	e8 dd 00 00 00       	call   686 <close>
 5a9:	83 c4 10             	add    $0x10,%esp
  return r;
 5ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 5af:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 5b2:	c9                   	leave  
 5b3:	c3                   	ret    

000005b4 <atoi>:

int
atoi(const char *s)
{
 5b4:	55                   	push   %ebp
 5b5:	89 e5                	mov    %esp,%ebp
 5b7:	83 ec 10             	sub    $0x10,%esp
 5ba:	e8 93 00 00 00       	call   652 <__x86.get_pc_thunk.ax>
 5bf:	05 89 09 00 00       	add    $0x989,%eax
  int n;

  n = 0;
 5c4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 5cb:	eb 25                	jmp    5f2 <atoi+0x3e>
    n = n*10 + *s++ - '0';
 5cd:	8b 55 fc             	mov    -0x4(%ebp),%edx
 5d0:	89 d0                	mov    %edx,%eax
 5d2:	c1 e0 02             	shl    $0x2,%eax
 5d5:	01 d0                	add    %edx,%eax
 5d7:	01 c0                	add    %eax,%eax
 5d9:	89 c1                	mov    %eax,%ecx
 5db:	8b 45 08             	mov    0x8(%ebp),%eax
 5de:	8d 50 01             	lea    0x1(%eax),%edx
 5e1:	89 55 08             	mov    %edx,0x8(%ebp)
 5e4:	0f b6 00             	movzbl (%eax),%eax
 5e7:	0f be c0             	movsbl %al,%eax
 5ea:	01 c8                	add    %ecx,%eax
 5ec:	83 e8 30             	sub    $0x30,%eax
 5ef:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 5f2:	8b 45 08             	mov    0x8(%ebp),%eax
 5f5:	0f b6 00             	movzbl (%eax),%eax
 5f8:	3c 2f                	cmp    $0x2f,%al
 5fa:	7e 0a                	jle    606 <atoi+0x52>
 5fc:	8b 45 08             	mov    0x8(%ebp),%eax
 5ff:	0f b6 00             	movzbl (%eax),%eax
 602:	3c 39                	cmp    $0x39,%al
 604:	7e c7                	jle    5cd <atoi+0x19>
  return n;
 606:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 609:	c9                   	leave  
 60a:	c3                   	ret    

0000060b <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 60b:	55                   	push   %ebp
 60c:	89 e5                	mov    %esp,%ebp
 60e:	83 ec 10             	sub    $0x10,%esp
 611:	e8 3c 00 00 00       	call   652 <__x86.get_pc_thunk.ax>
 616:	05 32 09 00 00       	add    $0x932,%eax
  char *dst;
  const char *src;

  dst = vdst;
 61b:	8b 45 08             	mov    0x8(%ebp),%eax
 61e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 621:	8b 45 0c             	mov    0xc(%ebp),%eax
 624:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 627:	eb 17                	jmp    640 <memmove+0x35>
    *dst++ = *src++;
 629:	8b 55 f8             	mov    -0x8(%ebp),%edx
 62c:	8d 42 01             	lea    0x1(%edx),%eax
 62f:	89 45 f8             	mov    %eax,-0x8(%ebp)
 632:	8b 45 fc             	mov    -0x4(%ebp),%eax
 635:	8d 48 01             	lea    0x1(%eax),%ecx
 638:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 63b:	0f b6 12             	movzbl (%edx),%edx
 63e:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 640:	8b 45 10             	mov    0x10(%ebp),%eax
 643:	8d 50 ff             	lea    -0x1(%eax),%edx
 646:	89 55 10             	mov    %edx,0x10(%ebp)
 649:	85 c0                	test   %eax,%eax
 64b:	7f dc                	jg     629 <memmove+0x1e>
  return vdst;
 64d:	8b 45 08             	mov    0x8(%ebp),%eax
}
 650:	c9                   	leave  
 651:	c3                   	ret    

00000652 <__x86.get_pc_thunk.ax>:
 652:	8b 04 24             	mov    (%esp),%eax
 655:	c3                   	ret    

00000656 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 656:	b8 01 00 00 00       	mov    $0x1,%eax
 65b:	cd 40                	int    $0x40
 65d:	c3                   	ret    

0000065e <exit>:
SYSCALL(exit)
 65e:	b8 02 00 00 00       	mov    $0x2,%eax
 663:	cd 40                	int    $0x40
 665:	c3                   	ret    

00000666 <wait>:
SYSCALL(wait)
 666:	b8 03 00 00 00       	mov    $0x3,%eax
 66b:	cd 40                	int    $0x40
 66d:	c3                   	ret    

0000066e <pipe>:
SYSCALL(pipe)
 66e:	b8 04 00 00 00       	mov    $0x4,%eax
 673:	cd 40                	int    $0x40
 675:	c3                   	ret    

00000676 <read>:
SYSCALL(read)
 676:	b8 05 00 00 00       	mov    $0x5,%eax
 67b:	cd 40                	int    $0x40
 67d:	c3                   	ret    

0000067e <write>:
SYSCALL(write)
 67e:	b8 10 00 00 00       	mov    $0x10,%eax
 683:	cd 40                	int    $0x40
 685:	c3                   	ret    

00000686 <close>:
SYSCALL(close)
 686:	b8 15 00 00 00       	mov    $0x15,%eax
 68b:	cd 40                	int    $0x40
 68d:	c3                   	ret    

0000068e <kill>:
SYSCALL(kill)
 68e:	b8 06 00 00 00       	mov    $0x6,%eax
 693:	cd 40                	int    $0x40
 695:	c3                   	ret    

00000696 <exec>:
SYSCALL(exec)
 696:	b8 07 00 00 00       	mov    $0x7,%eax
 69b:	cd 40                	int    $0x40
 69d:	c3                   	ret    

0000069e <open>:
SYSCALL(open)
 69e:	b8 0f 00 00 00       	mov    $0xf,%eax
 6a3:	cd 40                	int    $0x40
 6a5:	c3                   	ret    

000006a6 <mknod>:
SYSCALL(mknod)
 6a6:	b8 11 00 00 00       	mov    $0x11,%eax
 6ab:	cd 40                	int    $0x40
 6ad:	c3                   	ret    

000006ae <unlink>:
SYSCALL(unlink)
 6ae:	b8 12 00 00 00       	mov    $0x12,%eax
 6b3:	cd 40                	int    $0x40
 6b5:	c3                   	ret    

000006b6 <fstat>:
SYSCALL(fstat)
 6b6:	b8 08 00 00 00       	mov    $0x8,%eax
 6bb:	cd 40                	int    $0x40
 6bd:	c3                   	ret    

000006be <link>:
SYSCALL(link)
 6be:	b8 13 00 00 00       	mov    $0x13,%eax
 6c3:	cd 40                	int    $0x40
 6c5:	c3                   	ret    

000006c6 <mkdir>:
SYSCALL(mkdir)
 6c6:	b8 14 00 00 00       	mov    $0x14,%eax
 6cb:	cd 40                	int    $0x40
 6cd:	c3                   	ret    

000006ce <chdir>:
SYSCALL(chdir)
 6ce:	b8 09 00 00 00       	mov    $0x9,%eax
 6d3:	cd 40                	int    $0x40
 6d5:	c3                   	ret    

000006d6 <dup>:
SYSCALL(dup)
 6d6:	b8 0a 00 00 00       	mov    $0xa,%eax
 6db:	cd 40                	int    $0x40
 6dd:	c3                   	ret    

000006de <getpid>:
SYSCALL(getpid)
 6de:	b8 0b 00 00 00       	mov    $0xb,%eax
 6e3:	cd 40                	int    $0x40
 6e5:	c3                   	ret    

000006e6 <sbrk>:
SYSCALL(sbrk)
 6e6:	b8 0c 00 00 00       	mov    $0xc,%eax
 6eb:	cd 40                	int    $0x40
 6ed:	c3                   	ret    

000006ee <sleep>:
SYSCALL(sleep)
 6ee:	b8 0d 00 00 00       	mov    $0xd,%eax
 6f3:	cd 40                	int    $0x40
 6f5:	c3                   	ret    

000006f6 <uptime>:
SYSCALL(uptime)
 6f6:	b8 0e 00 00 00       	mov    $0xe,%eax
 6fb:	cd 40                	int    $0x40
 6fd:	c3                   	ret    

000006fe <random>:
SYSCALL(random)
 6fe:	b8 16 00 00 00       	mov    $0x16,%eax
 703:	cd 40                	int    $0x40
 705:	c3                   	ret    

00000706 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 706:	55                   	push   %ebp
 707:	89 e5                	mov    %esp,%ebp
 709:	53                   	push   %ebx
 70a:	83 ec 14             	sub    $0x14,%esp
 70d:	e8 40 ff ff ff       	call   652 <__x86.get_pc_thunk.ax>
 712:	05 36 08 00 00       	add    $0x836,%eax
 717:	8b 55 0c             	mov    0xc(%ebp),%edx
 71a:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 71d:	83 ec 04             	sub    $0x4,%esp
 720:	6a 01                	push   $0x1
 722:	8d 55 f4             	lea    -0xc(%ebp),%edx
 725:	52                   	push   %edx
 726:	ff 75 08             	push   0x8(%ebp)
 729:	89 c3                	mov    %eax,%ebx
 72b:	e8 4e ff ff ff       	call   67e <write>
 730:	83 c4 10             	add    $0x10,%esp
}
 733:	90                   	nop
 734:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 737:	c9                   	leave  
 738:	c3                   	ret    

00000739 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 739:	55                   	push   %ebp
 73a:	89 e5                	mov    %esp,%ebp
 73c:	53                   	push   %ebx
 73d:	83 ec 24             	sub    $0x24,%esp
 740:	e8 58 02 00 00       	call   99d <__x86.get_pc_thunk.cx>
 745:	81 c1 03 08 00 00    	add    $0x803,%ecx
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 74b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 752:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 756:	74 17                	je     76f <printint+0x36>
 758:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 75c:	79 11                	jns    76f <printint+0x36>
    neg = 1;
 75e:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 765:	8b 45 0c             	mov    0xc(%ebp),%eax
 768:	f7 d8                	neg    %eax
 76a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 76d:	eb 06                	jmp    775 <printint+0x3c>
  } else {
    x = xx;
 76f:	8b 45 0c             	mov    0xc(%ebp),%eax
 772:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 775:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 77c:	8b 5d 10             	mov    0x10(%ebp),%ebx
 77f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 782:	ba 00 00 00 00       	mov    $0x0,%edx
 787:	f7 f3                	div    %ebx
 789:	89 d3                	mov    %edx,%ebx
 78b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 78e:	8d 50 01             	lea    0x1(%eax),%edx
 791:	89 55 f4             	mov    %edx,-0xc(%ebp)
 794:	0f b6 94 19 0c 00 00 	movzbl 0xc(%ecx,%ebx,1),%edx
 79b:	00 
 79c:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 7a0:	8b 5d 10             	mov    0x10(%ebp),%ebx
 7a3:	8b 45 ec             	mov    -0x14(%ebp),%eax
 7a6:	ba 00 00 00 00       	mov    $0x0,%edx
 7ab:	f7 f3                	div    %ebx
 7ad:	89 45 ec             	mov    %eax,-0x14(%ebp)
 7b0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 7b4:	75 c6                	jne    77c <printint+0x43>
  if(neg)
 7b6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7ba:	74 2d                	je     7e9 <printint+0xb0>
    buf[i++] = '-';
 7bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7bf:	8d 50 01             	lea    0x1(%eax),%edx
 7c2:	89 55 f4             	mov    %edx,-0xc(%ebp)
 7c5:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 7ca:	eb 1d                	jmp    7e9 <printint+0xb0>
    putc(fd, buf[i]);
 7cc:	8d 55 dc             	lea    -0x24(%ebp),%edx
 7cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d2:	01 d0                	add    %edx,%eax
 7d4:	0f b6 00             	movzbl (%eax),%eax
 7d7:	0f be c0             	movsbl %al,%eax
 7da:	83 ec 08             	sub    $0x8,%esp
 7dd:	50                   	push   %eax
 7de:	ff 75 08             	push   0x8(%ebp)
 7e1:	e8 20 ff ff ff       	call   706 <putc>
 7e6:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 7e9:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 7ed:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7f1:	79 d9                	jns    7cc <printint+0x93>
}
 7f3:	90                   	nop
 7f4:	90                   	nop
 7f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 7f8:	c9                   	leave  
 7f9:	c3                   	ret    

000007fa <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 7fa:	55                   	push   %ebp
 7fb:	89 e5                	mov    %esp,%ebp
 7fd:	53                   	push   %ebx
 7fe:	83 ec 24             	sub    $0x24,%esp
 801:	e8 8b fb ff ff       	call   391 <__x86.get_pc_thunk.bx>
 806:	81 c3 42 07 00 00    	add    $0x742,%ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 80c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 813:	8d 45 0c             	lea    0xc(%ebp),%eax
 816:	83 c0 04             	add    $0x4,%eax
 819:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 81c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 823:	e9 5b 01 00 00       	jmp    983 <printf+0x189>
    c = fmt[i] & 0xff;
 828:	8b 55 0c             	mov    0xc(%ebp),%edx
 82b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 82e:	01 d0                	add    %edx,%eax
 830:	0f b6 00             	movzbl (%eax),%eax
 833:	0f be c0             	movsbl %al,%eax
 836:	25 ff 00 00 00       	and    $0xff,%eax
 83b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 83e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 842:	75 2c                	jne    870 <printf+0x76>
      if(c == '%'){
 844:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 848:	75 0c                	jne    856 <printf+0x5c>
        state = '%';
 84a:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 851:	e9 29 01 00 00       	jmp    97f <printf+0x185>
      } else {
        putc(fd, c);
 856:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 859:	0f be c0             	movsbl %al,%eax
 85c:	83 ec 08             	sub    $0x8,%esp
 85f:	50                   	push   %eax
 860:	ff 75 08             	push   0x8(%ebp)
 863:	e8 9e fe ff ff       	call   706 <putc>
 868:	83 c4 10             	add    $0x10,%esp
 86b:	e9 0f 01 00 00       	jmp    97f <printf+0x185>
      }
    } else if(state == '%'){
 870:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 874:	0f 85 05 01 00 00    	jne    97f <printf+0x185>
      if(c == 'd'){
 87a:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 87e:	75 1e                	jne    89e <printf+0xa4>
        printint(fd, *ap, 10, 1);
 880:	8b 45 e8             	mov    -0x18(%ebp),%eax
 883:	8b 00                	mov    (%eax),%eax
 885:	6a 01                	push   $0x1
 887:	6a 0a                	push   $0xa
 889:	50                   	push   %eax
 88a:	ff 75 08             	push   0x8(%ebp)
 88d:	e8 a7 fe ff ff       	call   739 <printint>
 892:	83 c4 10             	add    $0x10,%esp
        ap++;
 895:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 899:	e9 da 00 00 00       	jmp    978 <printf+0x17e>
      } else if(c == 'x' || c == 'p'){
 89e:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 8a2:	74 06                	je     8aa <printf+0xb0>
 8a4:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 8a8:	75 1e                	jne    8c8 <printf+0xce>
        printint(fd, *ap, 16, 0);
 8aa:	8b 45 e8             	mov    -0x18(%ebp),%eax
 8ad:	8b 00                	mov    (%eax),%eax
 8af:	6a 00                	push   $0x0
 8b1:	6a 10                	push   $0x10
 8b3:	50                   	push   %eax
 8b4:	ff 75 08             	push   0x8(%ebp)
 8b7:	e8 7d fe ff ff       	call   739 <printint>
 8bc:	83 c4 10             	add    $0x10,%esp
        ap++;
 8bf:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 8c3:	e9 b0 00 00 00       	jmp    978 <printf+0x17e>
      } else if(c == 's'){
 8c8:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 8cc:	75 45                	jne    913 <printf+0x119>
        s = (char*)*ap;
 8ce:	8b 45 e8             	mov    -0x18(%ebp),%eax
 8d1:	8b 00                	mov    (%eax),%eax
 8d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 8d6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 8da:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8de:	75 27                	jne    907 <printf+0x10d>
          s = "(null)";
 8e0:	8d 83 fb fc ff ff    	lea    -0x305(%ebx),%eax
 8e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while(*s != 0){
 8e9:	eb 1c                	jmp    907 <printf+0x10d>
          putc(fd, *s);
 8eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ee:	0f b6 00             	movzbl (%eax),%eax
 8f1:	0f be c0             	movsbl %al,%eax
 8f4:	83 ec 08             	sub    $0x8,%esp
 8f7:	50                   	push   %eax
 8f8:	ff 75 08             	push   0x8(%ebp)
 8fb:	e8 06 fe ff ff       	call   706 <putc>
 900:	83 c4 10             	add    $0x10,%esp
          s++;
 903:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 907:	8b 45 f4             	mov    -0xc(%ebp),%eax
 90a:	0f b6 00             	movzbl (%eax),%eax
 90d:	84 c0                	test   %al,%al
 90f:	75 da                	jne    8eb <printf+0xf1>
 911:	eb 65                	jmp    978 <printf+0x17e>
        }
      } else if(c == 'c'){
 913:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 917:	75 1d                	jne    936 <printf+0x13c>
        putc(fd, *ap);
 919:	8b 45 e8             	mov    -0x18(%ebp),%eax
 91c:	8b 00                	mov    (%eax),%eax
 91e:	0f be c0             	movsbl %al,%eax
 921:	83 ec 08             	sub    $0x8,%esp
 924:	50                   	push   %eax
 925:	ff 75 08             	push   0x8(%ebp)
 928:	e8 d9 fd ff ff       	call   706 <putc>
 92d:	83 c4 10             	add    $0x10,%esp
        ap++;
 930:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 934:	eb 42                	jmp    978 <printf+0x17e>
      } else if(c == '%'){
 936:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 93a:	75 17                	jne    953 <printf+0x159>
        putc(fd, c);
 93c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 93f:	0f be c0             	movsbl %al,%eax
 942:	83 ec 08             	sub    $0x8,%esp
 945:	50                   	push   %eax
 946:	ff 75 08             	push   0x8(%ebp)
 949:	e8 b8 fd ff ff       	call   706 <putc>
 94e:	83 c4 10             	add    $0x10,%esp
 951:	eb 25                	jmp    978 <printf+0x17e>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 953:	83 ec 08             	sub    $0x8,%esp
 956:	6a 25                	push   $0x25
 958:	ff 75 08             	push   0x8(%ebp)
 95b:	e8 a6 fd ff ff       	call   706 <putc>
 960:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 963:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 966:	0f be c0             	movsbl %al,%eax
 969:	83 ec 08             	sub    $0x8,%esp
 96c:	50                   	push   %eax
 96d:	ff 75 08             	push   0x8(%ebp)
 970:	e8 91 fd ff ff       	call   706 <putc>
 975:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 978:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 97f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 983:	8b 55 0c             	mov    0xc(%ebp),%edx
 986:	8b 45 f0             	mov    -0x10(%ebp),%eax
 989:	01 d0                	add    %edx,%eax
 98b:	0f b6 00             	movzbl (%eax),%eax
 98e:	84 c0                	test   %al,%al
 990:	0f 85 92 fe ff ff    	jne    828 <printf+0x2e>
    }
  }
}
 996:	90                   	nop
 997:	90                   	nop
 998:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 99b:	c9                   	leave  
 99c:	c3                   	ret    

0000099d <__x86.get_pc_thunk.cx>:
 99d:	8b 0c 24             	mov    (%esp),%ecx
 9a0:	c3                   	ret    

000009a1 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9a1:	55                   	push   %ebp
 9a2:	89 e5                	mov    %esp,%ebp
 9a4:	83 ec 10             	sub    $0x10,%esp
 9a7:	e8 a6 fc ff ff       	call   652 <__x86.get_pc_thunk.ax>
 9ac:	05 9c 05 00 00       	add    $0x59c,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9b1:	8b 55 08             	mov    0x8(%ebp),%edx
 9b4:	83 ea 08             	sub    $0x8,%edx
 9b7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9ba:	8b 90 38 00 00 00    	mov    0x38(%eax),%edx
 9c0:	89 55 fc             	mov    %edx,-0x4(%ebp)
 9c3:	eb 24                	jmp    9e9 <free+0x48>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9c5:	8b 55 fc             	mov    -0x4(%ebp),%edx
 9c8:	8b 12                	mov    (%edx),%edx
 9ca:	39 55 fc             	cmp    %edx,-0x4(%ebp)
 9cd:	72 12                	jb     9e1 <free+0x40>
 9cf:	8b 55 f8             	mov    -0x8(%ebp),%edx
 9d2:	3b 55 fc             	cmp    -0x4(%ebp),%edx
 9d5:	77 24                	ja     9fb <free+0x5a>
 9d7:	8b 55 fc             	mov    -0x4(%ebp),%edx
 9da:	8b 12                	mov    (%edx),%edx
 9dc:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 9df:	72 1a                	jb     9fb <free+0x5a>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9e1:	8b 55 fc             	mov    -0x4(%ebp),%edx
 9e4:	8b 12                	mov    (%edx),%edx
 9e6:	89 55 fc             	mov    %edx,-0x4(%ebp)
 9e9:	8b 55 f8             	mov    -0x8(%ebp),%edx
 9ec:	3b 55 fc             	cmp    -0x4(%ebp),%edx
 9ef:	76 d4                	jbe    9c5 <free+0x24>
 9f1:	8b 55 fc             	mov    -0x4(%ebp),%edx
 9f4:	8b 12                	mov    (%edx),%edx
 9f6:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 9f9:	73 ca                	jae    9c5 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 9fb:	8b 55 f8             	mov    -0x8(%ebp),%edx
 9fe:	8b 52 04             	mov    0x4(%edx),%edx
 a01:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
 a08:	8b 55 f8             	mov    -0x8(%ebp),%edx
 a0b:	01 d1                	add    %edx,%ecx
 a0d:	8b 55 fc             	mov    -0x4(%ebp),%edx
 a10:	8b 12                	mov    (%edx),%edx
 a12:	39 d1                	cmp    %edx,%ecx
 a14:	75 24                	jne    a3a <free+0x99>
    bp->s.size += p->s.ptr->s.size;
 a16:	8b 55 f8             	mov    -0x8(%ebp),%edx
 a19:	8b 4a 04             	mov    0x4(%edx),%ecx
 a1c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 a1f:	8b 12                	mov    (%edx),%edx
 a21:	8b 52 04             	mov    0x4(%edx),%edx
 a24:	01 d1                	add    %edx,%ecx
 a26:	8b 55 f8             	mov    -0x8(%ebp),%edx
 a29:	89 4a 04             	mov    %ecx,0x4(%edx)
    bp->s.ptr = p->s.ptr->s.ptr;
 a2c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 a2f:	8b 12                	mov    (%edx),%edx
 a31:	8b 0a                	mov    (%edx),%ecx
 a33:	8b 55 f8             	mov    -0x8(%ebp),%edx
 a36:	89 0a                	mov    %ecx,(%edx)
 a38:	eb 0a                	jmp    a44 <free+0xa3>
  } else
    bp->s.ptr = p->s.ptr;
 a3a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 a3d:	8b 0a                	mov    (%edx),%ecx
 a3f:	8b 55 f8             	mov    -0x8(%ebp),%edx
 a42:	89 0a                	mov    %ecx,(%edx)
  if(p + p->s.size == bp){
 a44:	8b 55 fc             	mov    -0x4(%ebp),%edx
 a47:	8b 52 04             	mov    0x4(%edx),%edx
 a4a:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
 a51:	8b 55 fc             	mov    -0x4(%ebp),%edx
 a54:	01 ca                	add    %ecx,%edx
 a56:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 a59:	75 20                	jne    a7b <free+0xda>
    p->s.size += bp->s.size;
 a5b:	8b 55 fc             	mov    -0x4(%ebp),%edx
 a5e:	8b 4a 04             	mov    0x4(%edx),%ecx
 a61:	8b 55 f8             	mov    -0x8(%ebp),%edx
 a64:	8b 52 04             	mov    0x4(%edx),%edx
 a67:	01 d1                	add    %edx,%ecx
 a69:	8b 55 fc             	mov    -0x4(%ebp),%edx
 a6c:	89 4a 04             	mov    %ecx,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 a6f:	8b 55 f8             	mov    -0x8(%ebp),%edx
 a72:	8b 0a                	mov    (%edx),%ecx
 a74:	8b 55 fc             	mov    -0x4(%ebp),%edx
 a77:	89 0a                	mov    %ecx,(%edx)
 a79:	eb 08                	jmp    a83 <free+0xe2>
  } else
    p->s.ptr = bp;
 a7b:	8b 55 fc             	mov    -0x4(%ebp),%edx
 a7e:	8b 4d f8             	mov    -0x8(%ebp),%ecx
 a81:	89 0a                	mov    %ecx,(%edx)
  freep = p;
 a83:	8b 55 fc             	mov    -0x4(%ebp),%edx
 a86:	89 90 38 00 00 00    	mov    %edx,0x38(%eax)
}
 a8c:	90                   	nop
 a8d:	c9                   	leave  
 a8e:	c3                   	ret    

00000a8f <morecore>:

static Header*
morecore(uint nu)
{
 a8f:	55                   	push   %ebp
 a90:	89 e5                	mov    %esp,%ebp
 a92:	53                   	push   %ebx
 a93:	83 ec 14             	sub    $0x14,%esp
 a96:	e8 f6 f8 ff ff       	call   391 <__x86.get_pc_thunk.bx>
 a9b:	81 c3 ad 04 00 00    	add    $0x4ad,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 aa1:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 aa8:	77 07                	ja     ab1 <morecore+0x22>
    nu = 4096;
 aaa:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 ab1:	8b 45 08             	mov    0x8(%ebp),%eax
 ab4:	c1 e0 03             	shl    $0x3,%eax
 ab7:	83 ec 0c             	sub    $0xc,%esp
 aba:	50                   	push   %eax
 abb:	e8 26 fc ff ff       	call   6e6 <sbrk>
 ac0:	83 c4 10             	add    $0x10,%esp
 ac3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 ac6:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 aca:	75 07                	jne    ad3 <morecore+0x44>
    return 0;
 acc:	b8 00 00 00 00       	mov    $0x0,%eax
 ad1:	eb 27                	jmp    afa <morecore+0x6b>
  hp = (Header*)p;
 ad3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ad6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 ad9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 adc:	8b 55 08             	mov    0x8(%ebp),%edx
 adf:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 ae2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 ae5:	83 c0 08             	add    $0x8,%eax
 ae8:	83 ec 0c             	sub    $0xc,%esp
 aeb:	50                   	push   %eax
 aec:	e8 b0 fe ff ff       	call   9a1 <free>
 af1:	83 c4 10             	add    $0x10,%esp
  return freep;
 af4:	8b 83 38 00 00 00    	mov    0x38(%ebx),%eax
}
 afa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 afd:	c9                   	leave  
 afe:	c3                   	ret    

00000aff <malloc>:

void*
malloc(uint nbytes)
{
 aff:	55                   	push   %ebp
 b00:	89 e5                	mov    %esp,%ebp
 b02:	53                   	push   %ebx
 b03:	83 ec 14             	sub    $0x14,%esp
 b06:	e8 86 f8 ff ff       	call   391 <__x86.get_pc_thunk.bx>
 b0b:	81 c3 3d 04 00 00    	add    $0x43d,%ebx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b11:	8b 45 08             	mov    0x8(%ebp),%eax
 b14:	83 c0 07             	add    $0x7,%eax
 b17:	c1 e8 03             	shr    $0x3,%eax
 b1a:	83 c0 01             	add    $0x1,%eax
 b1d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 b20:	8b 83 38 00 00 00    	mov    0x38(%ebx),%eax
 b26:	89 45 f0             	mov    %eax,-0x10(%ebp)
 b29:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 b2d:	75 28                	jne    b57 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
 b2f:	8d 83 30 00 00 00    	lea    0x30(%ebx),%eax
 b35:	89 45 f0             	mov    %eax,-0x10(%ebp)
 b38:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b3b:	89 83 38 00 00 00    	mov    %eax,0x38(%ebx)
 b41:	8b 83 38 00 00 00    	mov    0x38(%ebx),%eax
 b47:	89 83 30 00 00 00    	mov    %eax,0x30(%ebx)
    base.s.size = 0;
 b4d:	c7 83 34 00 00 00 00 	movl   $0x0,0x34(%ebx)
 b54:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b57:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b5a:	8b 00                	mov    (%eax),%eax
 b5c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 b5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b62:	8b 40 04             	mov    0x4(%eax),%eax
 b65:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 b68:	77 4e                	ja     bb8 <malloc+0xb9>
      if(p->s.size == nunits)
 b6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b6d:	8b 40 04             	mov    0x4(%eax),%eax
 b70:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 b73:	75 0c                	jne    b81 <malloc+0x82>
        prevp->s.ptr = p->s.ptr;
 b75:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b78:	8b 10                	mov    (%eax),%edx
 b7a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b7d:	89 10                	mov    %edx,(%eax)
 b7f:	eb 26                	jmp    ba7 <malloc+0xa8>
      else {
        p->s.size -= nunits;
 b81:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b84:	8b 40 04             	mov    0x4(%eax),%eax
 b87:	2b 45 ec             	sub    -0x14(%ebp),%eax
 b8a:	89 c2                	mov    %eax,%edx
 b8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b8f:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 b92:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b95:	8b 40 04             	mov    0x4(%eax),%eax
 b98:	c1 e0 03             	shl    $0x3,%eax
 b9b:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 b9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ba1:	8b 55 ec             	mov    -0x14(%ebp),%edx
 ba4:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 ba7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 baa:	89 83 38 00 00 00    	mov    %eax,0x38(%ebx)
      return (void*)(p + 1);
 bb0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bb3:	83 c0 08             	add    $0x8,%eax
 bb6:	eb 3c                	jmp    bf4 <malloc+0xf5>
    }
    if(p == freep)
 bb8:	8b 83 38 00 00 00    	mov    0x38(%ebx),%eax
 bbe:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 bc1:	75 1e                	jne    be1 <malloc+0xe2>
      if((p = morecore(nunits)) == 0)
 bc3:	83 ec 0c             	sub    $0xc,%esp
 bc6:	ff 75 ec             	push   -0x14(%ebp)
 bc9:	e8 c1 fe ff ff       	call   a8f <morecore>
 bce:	83 c4 10             	add    $0x10,%esp
 bd1:	89 45 f4             	mov    %eax,-0xc(%ebp)
 bd4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 bd8:	75 07                	jne    be1 <malloc+0xe2>
        return 0;
 bda:	b8 00 00 00 00       	mov    $0x0,%eax
 bdf:	eb 13                	jmp    bf4 <malloc+0xf5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 be1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 be4:	89 45 f0             	mov    %eax,-0x10(%ebp)
 be7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bea:	8b 00                	mov    (%eax),%eax
 bec:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 bef:	e9 6b ff ff ff       	jmp    b5f <malloc+0x60>
  }
}
 bf4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 bf7:	c9                   	leave  
 bf8:	c3                   	ret    


_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
   f:	81 ec 20 02 00 00    	sub    $0x220,%esp
  15:	e8 4a 01 00 00       	call   164 <__x86.get_pc_thunk.bx>
  1a:	81 c3 7e 0c 00 00    	add    $0xc7e,%ebx
  int fd, i;
  char path[] = "stressfs0";
  20:	c7 45 e6 73 74 72 65 	movl   $0x65727473,-0x1a(%ebp)
  27:	c7 45 ea 73 73 66 73 	movl   $0x73667373,-0x16(%ebp)
  2e:	66 c7 45 ee 30 00    	movw   $0x30,-0x12(%ebp)
  char data[512];

  printf(1, "stressfs starting\n");
  34:	83 ec 08             	sub    $0x8,%esp
  37:	8d 83 34 fd ff ff    	lea    -0x2cc(%ebx),%eax
  3d:	50                   	push   %eax
  3e:	6a 01                	push   $0x1
  40:	e8 88 05 00 00       	call   5cd <printf>
  45:	83 c4 10             	add    $0x10,%esp
  memset(data, 'a', sizeof(data));
  48:	83 ec 04             	sub    $0x4,%esp
  4b:	68 00 02 00 00       	push   $0x200
  50:	6a 61                	push   $0x61
  52:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
  58:	50                   	push   %eax
  59:	e8 ee 01 00 00       	call   24c <memset>
  5e:	83 c4 10             	add    $0x10,%esp

  for(i = 0; i < 4; i++)
  61:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  68:	eb 0d                	jmp    77 <main+0x77>
    if(fork() > 0)
  6a:	e8 ba 03 00 00       	call   429 <fork>
  6f:	85 c0                	test   %eax,%eax
  71:	7f 0c                	jg     7f <main+0x7f>
  for(i = 0; i < 4; i++)
  73:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  77:	83 7d f4 03          	cmpl   $0x3,-0xc(%ebp)
  7b:	7e ed                	jle    6a <main+0x6a>
  7d:	eb 01                	jmp    80 <main+0x80>
      break;
  7f:	90                   	nop

  printf(1, "write %d\n", i);
  80:	83 ec 04             	sub    $0x4,%esp
  83:	ff 75 f4             	push   -0xc(%ebp)
  86:	8d 83 47 fd ff ff    	lea    -0x2b9(%ebx),%eax
  8c:	50                   	push   %eax
  8d:	6a 01                	push   $0x1
  8f:	e8 39 05 00 00       	call   5cd <printf>
  94:	83 c4 10             	add    $0x10,%esp

  path[8] += i;
  97:	0f b6 45 ee          	movzbl -0x12(%ebp),%eax
  9b:	89 c2                	mov    %eax,%edx
  9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  a0:	01 d0                	add    %edx,%eax
  a2:	88 45 ee             	mov    %al,-0x12(%ebp)
  fd = open(path, O_CREATE | O_RDWR);
  a5:	83 ec 08             	sub    $0x8,%esp
  a8:	68 02 02 00 00       	push   $0x202
  ad:	8d 45 e6             	lea    -0x1a(%ebp),%eax
  b0:	50                   	push   %eax
  b1:	e8 bb 03 00 00       	call   471 <open>
  b6:	83 c4 10             	add    $0x10,%esp
  b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; i < 20; i++)
  bc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  c3:	eb 1e                	jmp    e3 <main+0xe3>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  c5:	83 ec 04             	sub    $0x4,%esp
  c8:	68 00 02 00 00       	push   $0x200
  cd:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
  d3:	50                   	push   %eax
  d4:	ff 75 f0             	push   -0x10(%ebp)
  d7:	e8 75 03 00 00       	call   451 <write>
  dc:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 20; i++)
  df:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  e3:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
  e7:	7e dc                	jle    c5 <main+0xc5>
  close(fd);
  e9:	83 ec 0c             	sub    $0xc,%esp
  ec:	ff 75 f0             	push   -0x10(%ebp)
  ef:	e8 65 03 00 00       	call   459 <close>
  f4:	83 c4 10             	add    $0x10,%esp

  printf(1, "read\n");
  f7:	83 ec 08             	sub    $0x8,%esp
  fa:	8d 83 51 fd ff ff    	lea    -0x2af(%ebx),%eax
 100:	50                   	push   %eax
 101:	6a 01                	push   $0x1
 103:	e8 c5 04 00 00       	call   5cd <printf>
 108:	83 c4 10             	add    $0x10,%esp

  fd = open(path, O_RDONLY);
 10b:	83 ec 08             	sub    $0x8,%esp
 10e:	6a 00                	push   $0x0
 110:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 113:	50                   	push   %eax
 114:	e8 58 03 00 00       	call   471 <open>
 119:	83 c4 10             	add    $0x10,%esp
 11c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for (i = 0; i < 20; i++)
 11f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 126:	eb 1e                	jmp    146 <main+0x146>
    read(fd, data, sizeof(data));
 128:	83 ec 04             	sub    $0x4,%esp
 12b:	68 00 02 00 00       	push   $0x200
 130:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
 136:	50                   	push   %eax
 137:	ff 75 f0             	push   -0x10(%ebp)
 13a:	e8 0a 03 00 00       	call   449 <read>
 13f:	83 c4 10             	add    $0x10,%esp
  for (i = 0; i < 20; i++)
 142:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 146:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
 14a:	7e dc                	jle    128 <main+0x128>
  close(fd);
 14c:	83 ec 0c             	sub    $0xc,%esp
 14f:	ff 75 f0             	push   -0x10(%ebp)
 152:	e8 02 03 00 00       	call   459 <close>
 157:	83 c4 10             	add    $0x10,%esp

  wait();
 15a:	e8 da 02 00 00       	call   439 <wait>

  exit();
 15f:	e8 cd 02 00 00       	call   431 <exit>

00000164 <__x86.get_pc_thunk.bx>:
 164:	8b 1c 24             	mov    (%esp),%ebx
 167:	c3                   	ret    

00000168 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 168:	55                   	push   %ebp
 169:	89 e5                	mov    %esp,%ebp
 16b:	57                   	push   %edi
 16c:	53                   	push   %ebx
 16d:	e8 b3 02 00 00       	call   425 <__x86.get_pc_thunk.ax>
 172:	05 26 0b 00 00       	add    $0xb26,%eax
  asm volatile("cld; rep stosb" :
 177:	8b 4d 08             	mov    0x8(%ebp),%ecx
 17a:	8b 55 10             	mov    0x10(%ebp),%edx
 17d:	8b 45 0c             	mov    0xc(%ebp),%eax
 180:	89 cb                	mov    %ecx,%ebx
 182:	89 df                	mov    %ebx,%edi
 184:	89 d1                	mov    %edx,%ecx
 186:	fc                   	cld    
 187:	f3 aa                	rep stos %al,%es:(%edi)
 189:	89 ca                	mov    %ecx,%edx
 18b:	89 fb                	mov    %edi,%ebx
 18d:	89 5d 08             	mov    %ebx,0x8(%ebp)
 190:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 193:	90                   	nop
 194:	5b                   	pop    %ebx
 195:	5f                   	pop    %edi
 196:	5d                   	pop    %ebp
 197:	c3                   	ret    

00000198 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 198:	55                   	push   %ebp
 199:	89 e5                	mov    %esp,%ebp
 19b:	83 ec 10             	sub    $0x10,%esp
 19e:	e8 82 02 00 00       	call   425 <__x86.get_pc_thunk.ax>
 1a3:	05 f5 0a 00 00       	add    $0xaf5,%eax
  char *os;

  os = s;
 1a8:	8b 45 08             	mov    0x8(%ebp),%eax
 1ab:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 1ae:	90                   	nop
 1af:	8b 55 0c             	mov    0xc(%ebp),%edx
 1b2:	8d 42 01             	lea    0x1(%edx),%eax
 1b5:	89 45 0c             	mov    %eax,0xc(%ebp)
 1b8:	8b 45 08             	mov    0x8(%ebp),%eax
 1bb:	8d 48 01             	lea    0x1(%eax),%ecx
 1be:	89 4d 08             	mov    %ecx,0x8(%ebp)
 1c1:	0f b6 12             	movzbl (%edx),%edx
 1c4:	88 10                	mov    %dl,(%eax)
 1c6:	0f b6 00             	movzbl (%eax),%eax
 1c9:	84 c0                	test   %al,%al
 1cb:	75 e2                	jne    1af <strcpy+0x17>
    ;
  return os;
 1cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1d0:	c9                   	leave  
 1d1:	c3                   	ret    

000001d2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1d2:	55                   	push   %ebp
 1d3:	89 e5                	mov    %esp,%ebp
 1d5:	e8 4b 02 00 00       	call   425 <__x86.get_pc_thunk.ax>
 1da:	05 be 0a 00 00       	add    $0xabe,%eax
  while(*p && *p == *q)
 1df:	eb 08                	jmp    1e9 <strcmp+0x17>
    p++, q++;
 1e1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1e5:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 1e9:	8b 45 08             	mov    0x8(%ebp),%eax
 1ec:	0f b6 00             	movzbl (%eax),%eax
 1ef:	84 c0                	test   %al,%al
 1f1:	74 10                	je     203 <strcmp+0x31>
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	0f b6 10             	movzbl (%eax),%edx
 1f9:	8b 45 0c             	mov    0xc(%ebp),%eax
 1fc:	0f b6 00             	movzbl (%eax),%eax
 1ff:	38 c2                	cmp    %al,%dl
 201:	74 de                	je     1e1 <strcmp+0xf>
  return (uchar)*p - (uchar)*q;
 203:	8b 45 08             	mov    0x8(%ebp),%eax
 206:	0f b6 00             	movzbl (%eax),%eax
 209:	0f b6 d0             	movzbl %al,%edx
 20c:	8b 45 0c             	mov    0xc(%ebp),%eax
 20f:	0f b6 00             	movzbl (%eax),%eax
 212:	0f b6 c8             	movzbl %al,%ecx
 215:	89 d0                	mov    %edx,%eax
 217:	29 c8                	sub    %ecx,%eax
}
 219:	5d                   	pop    %ebp
 21a:	c3                   	ret    

0000021b <strlen>:

uint
strlen(const char *s)
{
 21b:	55                   	push   %ebp
 21c:	89 e5                	mov    %esp,%ebp
 21e:	83 ec 10             	sub    $0x10,%esp
 221:	e8 ff 01 00 00       	call   425 <__x86.get_pc_thunk.ax>
 226:	05 72 0a 00 00       	add    $0xa72,%eax
  int n;

  for(n = 0; s[n]; n++)
 22b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 232:	eb 04                	jmp    238 <strlen+0x1d>
 234:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 238:	8b 55 fc             	mov    -0x4(%ebp),%edx
 23b:	8b 45 08             	mov    0x8(%ebp),%eax
 23e:	01 d0                	add    %edx,%eax
 240:	0f b6 00             	movzbl (%eax),%eax
 243:	84 c0                	test   %al,%al
 245:	75 ed                	jne    234 <strlen+0x19>
    ;
  return n;
 247:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 24a:	c9                   	leave  
 24b:	c3                   	ret    

0000024c <memset>:

void*
memset(void *dst, int c, uint n)
{
 24c:	55                   	push   %ebp
 24d:	89 e5                	mov    %esp,%ebp
 24f:	e8 d1 01 00 00       	call   425 <__x86.get_pc_thunk.ax>
 254:	05 44 0a 00 00       	add    $0xa44,%eax
  stosb(dst, c, n);
 259:	8b 45 10             	mov    0x10(%ebp),%eax
 25c:	50                   	push   %eax
 25d:	ff 75 0c             	push   0xc(%ebp)
 260:	ff 75 08             	push   0x8(%ebp)
 263:	e8 00 ff ff ff       	call   168 <stosb>
 268:	83 c4 0c             	add    $0xc,%esp
  return dst;
 26b:	8b 45 08             	mov    0x8(%ebp),%eax
}
 26e:	c9                   	leave  
 26f:	c3                   	ret    

00000270 <strchr>:

char*
strchr(const char *s, char c)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	83 ec 04             	sub    $0x4,%esp
 276:	e8 aa 01 00 00       	call   425 <__x86.get_pc_thunk.ax>
 27b:	05 1d 0a 00 00       	add    $0xa1d,%eax
 280:	8b 45 0c             	mov    0xc(%ebp),%eax
 283:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 286:	eb 14                	jmp    29c <strchr+0x2c>
    if(*s == c)
 288:	8b 45 08             	mov    0x8(%ebp),%eax
 28b:	0f b6 00             	movzbl (%eax),%eax
 28e:	38 45 fc             	cmp    %al,-0x4(%ebp)
 291:	75 05                	jne    298 <strchr+0x28>
      return (char*)s;
 293:	8b 45 08             	mov    0x8(%ebp),%eax
 296:	eb 13                	jmp    2ab <strchr+0x3b>
  for(; *s; s++)
 298:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 29c:	8b 45 08             	mov    0x8(%ebp),%eax
 29f:	0f b6 00             	movzbl (%eax),%eax
 2a2:	84 c0                	test   %al,%al
 2a4:	75 e2                	jne    288 <strchr+0x18>
  return 0;
 2a6:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2ab:	c9                   	leave  
 2ac:	c3                   	ret    

000002ad <gets>:

char*
gets(char *buf, int max)
{
 2ad:	55                   	push   %ebp
 2ae:	89 e5                	mov    %esp,%ebp
 2b0:	53                   	push   %ebx
 2b1:	83 ec 14             	sub    $0x14,%esp
 2b4:	e8 ab fe ff ff       	call   164 <__x86.get_pc_thunk.bx>
 2b9:	81 c3 df 09 00 00    	add    $0x9df,%ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2bf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2c6:	eb 42                	jmp    30a <gets+0x5d>
    cc = read(0, &c, 1);
 2c8:	83 ec 04             	sub    $0x4,%esp
 2cb:	6a 01                	push   $0x1
 2cd:	8d 45 ef             	lea    -0x11(%ebp),%eax
 2d0:	50                   	push   %eax
 2d1:	6a 00                	push   $0x0
 2d3:	e8 71 01 00 00       	call   449 <read>
 2d8:	83 c4 10             	add    $0x10,%esp
 2db:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 2de:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2e2:	7e 33                	jle    317 <gets+0x6a>
      break;
    buf[i++] = c;
 2e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2e7:	8d 50 01             	lea    0x1(%eax),%edx
 2ea:	89 55 f4             	mov    %edx,-0xc(%ebp)
 2ed:	89 c2                	mov    %eax,%edx
 2ef:	8b 45 08             	mov    0x8(%ebp),%eax
 2f2:	01 c2                	add    %eax,%edx
 2f4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2f8:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 2fa:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2fe:	3c 0a                	cmp    $0xa,%al
 300:	74 16                	je     318 <gets+0x6b>
 302:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 306:	3c 0d                	cmp    $0xd,%al
 308:	74 0e                	je     318 <gets+0x6b>
  for(i=0; i+1 < max; ){
 30a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 30d:	83 c0 01             	add    $0x1,%eax
 310:	39 45 0c             	cmp    %eax,0xc(%ebp)
 313:	7f b3                	jg     2c8 <gets+0x1b>
 315:	eb 01                	jmp    318 <gets+0x6b>
      break;
 317:	90                   	nop
      break;
  }
  buf[i] = '\0';
 318:	8b 55 f4             	mov    -0xc(%ebp),%edx
 31b:	8b 45 08             	mov    0x8(%ebp),%eax
 31e:	01 d0                	add    %edx,%eax
 320:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 323:	8b 45 08             	mov    0x8(%ebp),%eax
}
 326:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 329:	c9                   	leave  
 32a:	c3                   	ret    

0000032b <stat>:

int
stat(const char *n, struct stat *st)
{
 32b:	55                   	push   %ebp
 32c:	89 e5                	mov    %esp,%ebp
 32e:	53                   	push   %ebx
 32f:	83 ec 14             	sub    $0x14,%esp
 332:	e8 2d fe ff ff       	call   164 <__x86.get_pc_thunk.bx>
 337:	81 c3 61 09 00 00    	add    $0x961,%ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 33d:	83 ec 08             	sub    $0x8,%esp
 340:	6a 00                	push   $0x0
 342:	ff 75 08             	push   0x8(%ebp)
 345:	e8 27 01 00 00       	call   471 <open>
 34a:	83 c4 10             	add    $0x10,%esp
 34d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 350:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 354:	79 07                	jns    35d <stat+0x32>
    return -1;
 356:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 35b:	eb 25                	jmp    382 <stat+0x57>
  r = fstat(fd, st);
 35d:	83 ec 08             	sub    $0x8,%esp
 360:	ff 75 0c             	push   0xc(%ebp)
 363:	ff 75 f4             	push   -0xc(%ebp)
 366:	e8 1e 01 00 00       	call   489 <fstat>
 36b:	83 c4 10             	add    $0x10,%esp
 36e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 371:	83 ec 0c             	sub    $0xc,%esp
 374:	ff 75 f4             	push   -0xc(%ebp)
 377:	e8 dd 00 00 00       	call   459 <close>
 37c:	83 c4 10             	add    $0x10,%esp
  return r;
 37f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 382:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 385:	c9                   	leave  
 386:	c3                   	ret    

00000387 <atoi>:

int
atoi(const char *s)
{
 387:	55                   	push   %ebp
 388:	89 e5                	mov    %esp,%ebp
 38a:	83 ec 10             	sub    $0x10,%esp
 38d:	e8 93 00 00 00       	call   425 <__x86.get_pc_thunk.ax>
 392:	05 06 09 00 00       	add    $0x906,%eax
  int n;

  n = 0;
 397:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 39e:	eb 25                	jmp    3c5 <atoi+0x3e>
    n = n*10 + *s++ - '0';
 3a0:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3a3:	89 d0                	mov    %edx,%eax
 3a5:	c1 e0 02             	shl    $0x2,%eax
 3a8:	01 d0                	add    %edx,%eax
 3aa:	01 c0                	add    %eax,%eax
 3ac:	89 c1                	mov    %eax,%ecx
 3ae:	8b 45 08             	mov    0x8(%ebp),%eax
 3b1:	8d 50 01             	lea    0x1(%eax),%edx
 3b4:	89 55 08             	mov    %edx,0x8(%ebp)
 3b7:	0f b6 00             	movzbl (%eax),%eax
 3ba:	0f be c0             	movsbl %al,%eax
 3bd:	01 c8                	add    %ecx,%eax
 3bf:	83 e8 30             	sub    $0x30,%eax
 3c2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 3c5:	8b 45 08             	mov    0x8(%ebp),%eax
 3c8:	0f b6 00             	movzbl (%eax),%eax
 3cb:	3c 2f                	cmp    $0x2f,%al
 3cd:	7e 0a                	jle    3d9 <atoi+0x52>
 3cf:	8b 45 08             	mov    0x8(%ebp),%eax
 3d2:	0f b6 00             	movzbl (%eax),%eax
 3d5:	3c 39                	cmp    $0x39,%al
 3d7:	7e c7                	jle    3a0 <atoi+0x19>
  return n;
 3d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3dc:	c9                   	leave  
 3dd:	c3                   	ret    

000003de <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3de:	55                   	push   %ebp
 3df:	89 e5                	mov    %esp,%ebp
 3e1:	83 ec 10             	sub    $0x10,%esp
 3e4:	e8 3c 00 00 00       	call   425 <__x86.get_pc_thunk.ax>
 3e9:	05 af 08 00 00       	add    $0x8af,%eax
  char *dst;
  const char *src;

  dst = vdst;
 3ee:	8b 45 08             	mov    0x8(%ebp),%eax
 3f1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 3f4:	8b 45 0c             	mov    0xc(%ebp),%eax
 3f7:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 3fa:	eb 17                	jmp    413 <memmove+0x35>
    *dst++ = *src++;
 3fc:	8b 55 f8             	mov    -0x8(%ebp),%edx
 3ff:	8d 42 01             	lea    0x1(%edx),%eax
 402:	89 45 f8             	mov    %eax,-0x8(%ebp)
 405:	8b 45 fc             	mov    -0x4(%ebp),%eax
 408:	8d 48 01             	lea    0x1(%eax),%ecx
 40b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 40e:	0f b6 12             	movzbl (%edx),%edx
 411:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 413:	8b 45 10             	mov    0x10(%ebp),%eax
 416:	8d 50 ff             	lea    -0x1(%eax),%edx
 419:	89 55 10             	mov    %edx,0x10(%ebp)
 41c:	85 c0                	test   %eax,%eax
 41e:	7f dc                	jg     3fc <memmove+0x1e>
  return vdst;
 420:	8b 45 08             	mov    0x8(%ebp),%eax
}
 423:	c9                   	leave  
 424:	c3                   	ret    

00000425 <__x86.get_pc_thunk.ax>:
 425:	8b 04 24             	mov    (%esp),%eax
 428:	c3                   	ret    

00000429 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 429:	b8 01 00 00 00       	mov    $0x1,%eax
 42e:	cd 40                	int    $0x40
 430:	c3                   	ret    

00000431 <exit>:
SYSCALL(exit)
 431:	b8 02 00 00 00       	mov    $0x2,%eax
 436:	cd 40                	int    $0x40
 438:	c3                   	ret    

00000439 <wait>:
SYSCALL(wait)
 439:	b8 03 00 00 00       	mov    $0x3,%eax
 43e:	cd 40                	int    $0x40
 440:	c3                   	ret    

00000441 <pipe>:
SYSCALL(pipe)
 441:	b8 04 00 00 00       	mov    $0x4,%eax
 446:	cd 40                	int    $0x40
 448:	c3                   	ret    

00000449 <read>:
SYSCALL(read)
 449:	b8 05 00 00 00       	mov    $0x5,%eax
 44e:	cd 40                	int    $0x40
 450:	c3                   	ret    

00000451 <write>:
SYSCALL(write)
 451:	b8 10 00 00 00       	mov    $0x10,%eax
 456:	cd 40                	int    $0x40
 458:	c3                   	ret    

00000459 <close>:
SYSCALL(close)
 459:	b8 15 00 00 00       	mov    $0x15,%eax
 45e:	cd 40                	int    $0x40
 460:	c3                   	ret    

00000461 <kill>:
SYSCALL(kill)
 461:	b8 06 00 00 00       	mov    $0x6,%eax
 466:	cd 40                	int    $0x40
 468:	c3                   	ret    

00000469 <exec>:
SYSCALL(exec)
 469:	b8 07 00 00 00       	mov    $0x7,%eax
 46e:	cd 40                	int    $0x40
 470:	c3                   	ret    

00000471 <open>:
SYSCALL(open)
 471:	b8 0f 00 00 00       	mov    $0xf,%eax
 476:	cd 40                	int    $0x40
 478:	c3                   	ret    

00000479 <mknod>:
SYSCALL(mknod)
 479:	b8 11 00 00 00       	mov    $0x11,%eax
 47e:	cd 40                	int    $0x40
 480:	c3                   	ret    

00000481 <unlink>:
SYSCALL(unlink)
 481:	b8 12 00 00 00       	mov    $0x12,%eax
 486:	cd 40                	int    $0x40
 488:	c3                   	ret    

00000489 <fstat>:
SYSCALL(fstat)
 489:	b8 08 00 00 00       	mov    $0x8,%eax
 48e:	cd 40                	int    $0x40
 490:	c3                   	ret    

00000491 <link>:
SYSCALL(link)
 491:	b8 13 00 00 00       	mov    $0x13,%eax
 496:	cd 40                	int    $0x40
 498:	c3                   	ret    

00000499 <mkdir>:
SYSCALL(mkdir)
 499:	b8 14 00 00 00       	mov    $0x14,%eax
 49e:	cd 40                	int    $0x40
 4a0:	c3                   	ret    

000004a1 <chdir>:
SYSCALL(chdir)
 4a1:	b8 09 00 00 00       	mov    $0x9,%eax
 4a6:	cd 40                	int    $0x40
 4a8:	c3                   	ret    

000004a9 <dup>:
SYSCALL(dup)
 4a9:	b8 0a 00 00 00       	mov    $0xa,%eax
 4ae:	cd 40                	int    $0x40
 4b0:	c3                   	ret    

000004b1 <getpid>:
SYSCALL(getpid)
 4b1:	b8 0b 00 00 00       	mov    $0xb,%eax
 4b6:	cd 40                	int    $0x40
 4b8:	c3                   	ret    

000004b9 <sbrk>:
SYSCALL(sbrk)
 4b9:	b8 0c 00 00 00       	mov    $0xc,%eax
 4be:	cd 40                	int    $0x40
 4c0:	c3                   	ret    

000004c1 <sleep>:
SYSCALL(sleep)
 4c1:	b8 0d 00 00 00       	mov    $0xd,%eax
 4c6:	cd 40                	int    $0x40
 4c8:	c3                   	ret    

000004c9 <uptime>:
SYSCALL(uptime)
 4c9:	b8 0e 00 00 00       	mov    $0xe,%eax
 4ce:	cd 40                	int    $0x40
 4d0:	c3                   	ret    

000004d1 <random>:
SYSCALL(random)
 4d1:	b8 16 00 00 00       	mov    $0x16,%eax
 4d6:	cd 40                	int    $0x40
 4d8:	c3                   	ret    

000004d9 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4d9:	55                   	push   %ebp
 4da:	89 e5                	mov    %esp,%ebp
 4dc:	53                   	push   %ebx
 4dd:	83 ec 14             	sub    $0x14,%esp
 4e0:	e8 40 ff ff ff       	call   425 <__x86.get_pc_thunk.ax>
 4e5:	05 b3 07 00 00       	add    $0x7b3,%eax
 4ea:	8b 55 0c             	mov    0xc(%ebp),%edx
 4ed:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 4f0:	83 ec 04             	sub    $0x4,%esp
 4f3:	6a 01                	push   $0x1
 4f5:	8d 55 f4             	lea    -0xc(%ebp),%edx
 4f8:	52                   	push   %edx
 4f9:	ff 75 08             	push   0x8(%ebp)
 4fc:	89 c3                	mov    %eax,%ebx
 4fe:	e8 4e ff ff ff       	call   451 <write>
 503:	83 c4 10             	add    $0x10,%esp
}
 506:	90                   	nop
 507:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 50a:	c9                   	leave  
 50b:	c3                   	ret    

0000050c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 50c:	55                   	push   %ebp
 50d:	89 e5                	mov    %esp,%ebp
 50f:	53                   	push   %ebx
 510:	83 ec 24             	sub    $0x24,%esp
 513:	e8 58 02 00 00       	call   770 <__x86.get_pc_thunk.cx>
 518:	81 c1 80 07 00 00    	add    $0x780,%ecx
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 51e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 525:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 529:	74 17                	je     542 <printint+0x36>
 52b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 52f:	79 11                	jns    542 <printint+0x36>
    neg = 1;
 531:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 538:	8b 45 0c             	mov    0xc(%ebp),%eax
 53b:	f7 d8                	neg    %eax
 53d:	89 45 ec             	mov    %eax,-0x14(%ebp)
 540:	eb 06                	jmp    548 <printint+0x3c>
  } else {
    x = xx;
 542:	8b 45 0c             	mov    0xc(%ebp),%eax
 545:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 548:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 54f:	8b 5d 10             	mov    0x10(%ebp),%ebx
 552:	8b 45 ec             	mov    -0x14(%ebp),%eax
 555:	ba 00 00 00 00       	mov    $0x0,%edx
 55a:	f7 f3                	div    %ebx
 55c:	89 d3                	mov    %edx,%ebx
 55e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 561:	8d 50 01             	lea    0x1(%eax),%edx
 564:	89 55 f4             	mov    %edx,-0xc(%ebp)
 567:	0f b6 94 19 0c 00 00 	movzbl 0xc(%ecx,%ebx,1),%edx
 56e:	00 
 56f:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 573:	8b 5d 10             	mov    0x10(%ebp),%ebx
 576:	8b 45 ec             	mov    -0x14(%ebp),%eax
 579:	ba 00 00 00 00       	mov    $0x0,%edx
 57e:	f7 f3                	div    %ebx
 580:	89 45 ec             	mov    %eax,-0x14(%ebp)
 583:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 587:	75 c6                	jne    54f <printint+0x43>
  if(neg)
 589:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 58d:	74 2d                	je     5bc <printint+0xb0>
    buf[i++] = '-';
 58f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 592:	8d 50 01             	lea    0x1(%eax),%edx
 595:	89 55 f4             	mov    %edx,-0xc(%ebp)
 598:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 59d:	eb 1d                	jmp    5bc <printint+0xb0>
    putc(fd, buf[i]);
 59f:	8d 55 dc             	lea    -0x24(%ebp),%edx
 5a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5a5:	01 d0                	add    %edx,%eax
 5a7:	0f b6 00             	movzbl (%eax),%eax
 5aa:	0f be c0             	movsbl %al,%eax
 5ad:	83 ec 08             	sub    $0x8,%esp
 5b0:	50                   	push   %eax
 5b1:	ff 75 08             	push   0x8(%ebp)
 5b4:	e8 20 ff ff ff       	call   4d9 <putc>
 5b9:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 5bc:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 5c0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5c4:	79 d9                	jns    59f <printint+0x93>
}
 5c6:	90                   	nop
 5c7:	90                   	nop
 5c8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 5cb:	c9                   	leave  
 5cc:	c3                   	ret    

000005cd <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 5cd:	55                   	push   %ebp
 5ce:	89 e5                	mov    %esp,%ebp
 5d0:	53                   	push   %ebx
 5d1:	83 ec 24             	sub    $0x24,%esp
 5d4:	e8 8b fb ff ff       	call   164 <__x86.get_pc_thunk.bx>
 5d9:	81 c3 bf 06 00 00    	add    $0x6bf,%ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 5df:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 5e6:	8d 45 0c             	lea    0xc(%ebp),%eax
 5e9:	83 c0 04             	add    $0x4,%eax
 5ec:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 5ef:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 5f6:	e9 5b 01 00 00       	jmp    756 <printf+0x189>
    c = fmt[i] & 0xff;
 5fb:	8b 55 0c             	mov    0xc(%ebp),%edx
 5fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
 601:	01 d0                	add    %edx,%eax
 603:	0f b6 00             	movzbl (%eax),%eax
 606:	0f be c0             	movsbl %al,%eax
 609:	25 ff 00 00 00       	and    $0xff,%eax
 60e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 611:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 615:	75 2c                	jne    643 <printf+0x76>
      if(c == '%'){
 617:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 61b:	75 0c                	jne    629 <printf+0x5c>
        state = '%';
 61d:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 624:	e9 29 01 00 00       	jmp    752 <printf+0x185>
      } else {
        putc(fd, c);
 629:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 62c:	0f be c0             	movsbl %al,%eax
 62f:	83 ec 08             	sub    $0x8,%esp
 632:	50                   	push   %eax
 633:	ff 75 08             	push   0x8(%ebp)
 636:	e8 9e fe ff ff       	call   4d9 <putc>
 63b:	83 c4 10             	add    $0x10,%esp
 63e:	e9 0f 01 00 00       	jmp    752 <printf+0x185>
      }
    } else if(state == '%'){
 643:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 647:	0f 85 05 01 00 00    	jne    752 <printf+0x185>
      if(c == 'd'){
 64d:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 651:	75 1e                	jne    671 <printf+0xa4>
        printint(fd, *ap, 10, 1);
 653:	8b 45 e8             	mov    -0x18(%ebp),%eax
 656:	8b 00                	mov    (%eax),%eax
 658:	6a 01                	push   $0x1
 65a:	6a 0a                	push   $0xa
 65c:	50                   	push   %eax
 65d:	ff 75 08             	push   0x8(%ebp)
 660:	e8 a7 fe ff ff       	call   50c <printint>
 665:	83 c4 10             	add    $0x10,%esp
        ap++;
 668:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 66c:	e9 da 00 00 00       	jmp    74b <printf+0x17e>
      } else if(c == 'x' || c == 'p'){
 671:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 675:	74 06                	je     67d <printf+0xb0>
 677:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 67b:	75 1e                	jne    69b <printf+0xce>
        printint(fd, *ap, 16, 0);
 67d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 680:	8b 00                	mov    (%eax),%eax
 682:	6a 00                	push   $0x0
 684:	6a 10                	push   $0x10
 686:	50                   	push   %eax
 687:	ff 75 08             	push   0x8(%ebp)
 68a:	e8 7d fe ff ff       	call   50c <printint>
 68f:	83 c4 10             	add    $0x10,%esp
        ap++;
 692:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 696:	e9 b0 00 00 00       	jmp    74b <printf+0x17e>
      } else if(c == 's'){
 69b:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 69f:	75 45                	jne    6e6 <printf+0x119>
        s = (char*)*ap;
 6a1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6a4:	8b 00                	mov    (%eax),%eax
 6a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 6a9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 6ad:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6b1:	75 27                	jne    6da <printf+0x10d>
          s = "(null)";
 6b3:	8d 83 57 fd ff ff    	lea    -0x2a9(%ebx),%eax
 6b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while(*s != 0){
 6bc:	eb 1c                	jmp    6da <printf+0x10d>
          putc(fd, *s);
 6be:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6c1:	0f b6 00             	movzbl (%eax),%eax
 6c4:	0f be c0             	movsbl %al,%eax
 6c7:	83 ec 08             	sub    $0x8,%esp
 6ca:	50                   	push   %eax
 6cb:	ff 75 08             	push   0x8(%ebp)
 6ce:	e8 06 fe ff ff       	call   4d9 <putc>
 6d3:	83 c4 10             	add    $0x10,%esp
          s++;
 6d6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 6da:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6dd:	0f b6 00             	movzbl (%eax),%eax
 6e0:	84 c0                	test   %al,%al
 6e2:	75 da                	jne    6be <printf+0xf1>
 6e4:	eb 65                	jmp    74b <printf+0x17e>
        }
      } else if(c == 'c'){
 6e6:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 6ea:	75 1d                	jne    709 <printf+0x13c>
        putc(fd, *ap);
 6ec:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6ef:	8b 00                	mov    (%eax),%eax
 6f1:	0f be c0             	movsbl %al,%eax
 6f4:	83 ec 08             	sub    $0x8,%esp
 6f7:	50                   	push   %eax
 6f8:	ff 75 08             	push   0x8(%ebp)
 6fb:	e8 d9 fd ff ff       	call   4d9 <putc>
 700:	83 c4 10             	add    $0x10,%esp
        ap++;
 703:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 707:	eb 42                	jmp    74b <printf+0x17e>
      } else if(c == '%'){
 709:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 70d:	75 17                	jne    726 <printf+0x159>
        putc(fd, c);
 70f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 712:	0f be c0             	movsbl %al,%eax
 715:	83 ec 08             	sub    $0x8,%esp
 718:	50                   	push   %eax
 719:	ff 75 08             	push   0x8(%ebp)
 71c:	e8 b8 fd ff ff       	call   4d9 <putc>
 721:	83 c4 10             	add    $0x10,%esp
 724:	eb 25                	jmp    74b <printf+0x17e>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 726:	83 ec 08             	sub    $0x8,%esp
 729:	6a 25                	push   $0x25
 72b:	ff 75 08             	push   0x8(%ebp)
 72e:	e8 a6 fd ff ff       	call   4d9 <putc>
 733:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 736:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 739:	0f be c0             	movsbl %al,%eax
 73c:	83 ec 08             	sub    $0x8,%esp
 73f:	50                   	push   %eax
 740:	ff 75 08             	push   0x8(%ebp)
 743:	e8 91 fd ff ff       	call   4d9 <putc>
 748:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 74b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 752:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 756:	8b 55 0c             	mov    0xc(%ebp),%edx
 759:	8b 45 f0             	mov    -0x10(%ebp),%eax
 75c:	01 d0                	add    %edx,%eax
 75e:	0f b6 00             	movzbl (%eax),%eax
 761:	84 c0                	test   %al,%al
 763:	0f 85 92 fe ff ff    	jne    5fb <printf+0x2e>
    }
  }
}
 769:	90                   	nop
 76a:	90                   	nop
 76b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 76e:	c9                   	leave  
 76f:	c3                   	ret    

00000770 <__x86.get_pc_thunk.cx>:
 770:	8b 0c 24             	mov    (%esp),%ecx
 773:	c3                   	ret    

00000774 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 774:	55                   	push   %ebp
 775:	89 e5                	mov    %esp,%ebp
 777:	83 ec 10             	sub    $0x10,%esp
 77a:	e8 a6 fc ff ff       	call   425 <__x86.get_pc_thunk.ax>
 77f:	05 19 05 00 00       	add    $0x519,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
 784:	8b 55 08             	mov    0x8(%ebp),%edx
 787:	83 ea 08             	sub    $0x8,%edx
 78a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 78d:	8b 90 28 00 00 00    	mov    0x28(%eax),%edx
 793:	89 55 fc             	mov    %edx,-0x4(%ebp)
 796:	eb 24                	jmp    7bc <free+0x48>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 798:	8b 55 fc             	mov    -0x4(%ebp),%edx
 79b:	8b 12                	mov    (%edx),%edx
 79d:	39 55 fc             	cmp    %edx,-0x4(%ebp)
 7a0:	72 12                	jb     7b4 <free+0x40>
 7a2:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7a5:	3b 55 fc             	cmp    -0x4(%ebp),%edx
 7a8:	77 24                	ja     7ce <free+0x5a>
 7aa:	8b 55 fc             	mov    -0x4(%ebp),%edx
 7ad:	8b 12                	mov    (%edx),%edx
 7af:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 7b2:	72 1a                	jb     7ce <free+0x5a>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b4:	8b 55 fc             	mov    -0x4(%ebp),%edx
 7b7:	8b 12                	mov    (%edx),%edx
 7b9:	89 55 fc             	mov    %edx,-0x4(%ebp)
 7bc:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7bf:	3b 55 fc             	cmp    -0x4(%ebp),%edx
 7c2:	76 d4                	jbe    798 <free+0x24>
 7c4:	8b 55 fc             	mov    -0x4(%ebp),%edx
 7c7:	8b 12                	mov    (%edx),%edx
 7c9:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 7cc:	73 ca                	jae    798 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7ce:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7d1:	8b 52 04             	mov    0x4(%edx),%edx
 7d4:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
 7db:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7de:	01 d1                	add    %edx,%ecx
 7e0:	8b 55 fc             	mov    -0x4(%ebp),%edx
 7e3:	8b 12                	mov    (%edx),%edx
 7e5:	39 d1                	cmp    %edx,%ecx
 7e7:	75 24                	jne    80d <free+0x99>
    bp->s.size += p->s.ptr->s.size;
 7e9:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7ec:	8b 4a 04             	mov    0x4(%edx),%ecx
 7ef:	8b 55 fc             	mov    -0x4(%ebp),%edx
 7f2:	8b 12                	mov    (%edx),%edx
 7f4:	8b 52 04             	mov    0x4(%edx),%edx
 7f7:	01 d1                	add    %edx,%ecx
 7f9:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7fc:	89 4a 04             	mov    %ecx,0x4(%edx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7ff:	8b 55 fc             	mov    -0x4(%ebp),%edx
 802:	8b 12                	mov    (%edx),%edx
 804:	8b 0a                	mov    (%edx),%ecx
 806:	8b 55 f8             	mov    -0x8(%ebp),%edx
 809:	89 0a                	mov    %ecx,(%edx)
 80b:	eb 0a                	jmp    817 <free+0xa3>
  } else
    bp->s.ptr = p->s.ptr;
 80d:	8b 55 fc             	mov    -0x4(%ebp),%edx
 810:	8b 0a                	mov    (%edx),%ecx
 812:	8b 55 f8             	mov    -0x8(%ebp),%edx
 815:	89 0a                	mov    %ecx,(%edx)
  if(p + p->s.size == bp){
 817:	8b 55 fc             	mov    -0x4(%ebp),%edx
 81a:	8b 52 04             	mov    0x4(%edx),%edx
 81d:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
 824:	8b 55 fc             	mov    -0x4(%ebp),%edx
 827:	01 ca                	add    %ecx,%edx
 829:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 82c:	75 20                	jne    84e <free+0xda>
    p->s.size += bp->s.size;
 82e:	8b 55 fc             	mov    -0x4(%ebp),%edx
 831:	8b 4a 04             	mov    0x4(%edx),%ecx
 834:	8b 55 f8             	mov    -0x8(%ebp),%edx
 837:	8b 52 04             	mov    0x4(%edx),%edx
 83a:	01 d1                	add    %edx,%ecx
 83c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 83f:	89 4a 04             	mov    %ecx,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 842:	8b 55 f8             	mov    -0x8(%ebp),%edx
 845:	8b 0a                	mov    (%edx),%ecx
 847:	8b 55 fc             	mov    -0x4(%ebp),%edx
 84a:	89 0a                	mov    %ecx,(%edx)
 84c:	eb 08                	jmp    856 <free+0xe2>
  } else
    p->s.ptr = bp;
 84e:	8b 55 fc             	mov    -0x4(%ebp),%edx
 851:	8b 4d f8             	mov    -0x8(%ebp),%ecx
 854:	89 0a                	mov    %ecx,(%edx)
  freep = p;
 856:	8b 55 fc             	mov    -0x4(%ebp),%edx
 859:	89 90 28 00 00 00    	mov    %edx,0x28(%eax)
}
 85f:	90                   	nop
 860:	c9                   	leave  
 861:	c3                   	ret    

00000862 <morecore>:

static Header*
morecore(uint nu)
{
 862:	55                   	push   %ebp
 863:	89 e5                	mov    %esp,%ebp
 865:	53                   	push   %ebx
 866:	83 ec 14             	sub    $0x14,%esp
 869:	e8 f6 f8 ff ff       	call   164 <__x86.get_pc_thunk.bx>
 86e:	81 c3 2a 04 00 00    	add    $0x42a,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 874:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 87b:	77 07                	ja     884 <morecore+0x22>
    nu = 4096;
 87d:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 884:	8b 45 08             	mov    0x8(%ebp),%eax
 887:	c1 e0 03             	shl    $0x3,%eax
 88a:	83 ec 0c             	sub    $0xc,%esp
 88d:	50                   	push   %eax
 88e:	e8 26 fc ff ff       	call   4b9 <sbrk>
 893:	83 c4 10             	add    $0x10,%esp
 896:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 899:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 89d:	75 07                	jne    8a6 <morecore+0x44>
    return 0;
 89f:	b8 00 00 00 00       	mov    $0x0,%eax
 8a4:	eb 27                	jmp    8cd <morecore+0x6b>
  hp = (Header*)p;
 8a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 8ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8af:	8b 55 08             	mov    0x8(%ebp),%edx
 8b2:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 8b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8b8:	83 c0 08             	add    $0x8,%eax
 8bb:	83 ec 0c             	sub    $0xc,%esp
 8be:	50                   	push   %eax
 8bf:	e8 b0 fe ff ff       	call   774 <free>
 8c4:	83 c4 10             	add    $0x10,%esp
  return freep;
 8c7:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
}
 8cd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 8d0:	c9                   	leave  
 8d1:	c3                   	ret    

000008d2 <malloc>:

void*
malloc(uint nbytes)
{
 8d2:	55                   	push   %ebp
 8d3:	89 e5                	mov    %esp,%ebp
 8d5:	53                   	push   %ebx
 8d6:	83 ec 14             	sub    $0x14,%esp
 8d9:	e8 86 f8 ff ff       	call   164 <__x86.get_pc_thunk.bx>
 8de:	81 c3 ba 03 00 00    	add    $0x3ba,%ebx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8e4:	8b 45 08             	mov    0x8(%ebp),%eax
 8e7:	83 c0 07             	add    $0x7,%eax
 8ea:	c1 e8 03             	shr    $0x3,%eax
 8ed:	83 c0 01             	add    $0x1,%eax
 8f0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 8f3:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
 8f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8fc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 900:	75 28                	jne    92a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
 902:	8d 83 20 00 00 00    	lea    0x20(%ebx),%eax
 908:	89 45 f0             	mov    %eax,-0x10(%ebp)
 90b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 90e:	89 83 28 00 00 00    	mov    %eax,0x28(%ebx)
 914:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
 91a:	89 83 20 00 00 00    	mov    %eax,0x20(%ebx)
    base.s.size = 0;
 920:	c7 83 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
 927:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 92a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 92d:	8b 00                	mov    (%eax),%eax
 92f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 932:	8b 45 f4             	mov    -0xc(%ebp),%eax
 935:	8b 40 04             	mov    0x4(%eax),%eax
 938:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 93b:	77 4e                	ja     98b <malloc+0xb9>
      if(p->s.size == nunits)
 93d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 940:	8b 40 04             	mov    0x4(%eax),%eax
 943:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 946:	75 0c                	jne    954 <malloc+0x82>
        prevp->s.ptr = p->s.ptr;
 948:	8b 45 f4             	mov    -0xc(%ebp),%eax
 94b:	8b 10                	mov    (%eax),%edx
 94d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 950:	89 10                	mov    %edx,(%eax)
 952:	eb 26                	jmp    97a <malloc+0xa8>
      else {
        p->s.size -= nunits;
 954:	8b 45 f4             	mov    -0xc(%ebp),%eax
 957:	8b 40 04             	mov    0x4(%eax),%eax
 95a:	2b 45 ec             	sub    -0x14(%ebp),%eax
 95d:	89 c2                	mov    %eax,%edx
 95f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 962:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 965:	8b 45 f4             	mov    -0xc(%ebp),%eax
 968:	8b 40 04             	mov    0x4(%eax),%eax
 96b:	c1 e0 03             	shl    $0x3,%eax
 96e:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 971:	8b 45 f4             	mov    -0xc(%ebp),%eax
 974:	8b 55 ec             	mov    -0x14(%ebp),%edx
 977:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 97a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 97d:	89 83 28 00 00 00    	mov    %eax,0x28(%ebx)
      return (void*)(p + 1);
 983:	8b 45 f4             	mov    -0xc(%ebp),%eax
 986:	83 c0 08             	add    $0x8,%eax
 989:	eb 3c                	jmp    9c7 <malloc+0xf5>
    }
    if(p == freep)
 98b:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
 991:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 994:	75 1e                	jne    9b4 <malloc+0xe2>
      if((p = morecore(nunits)) == 0)
 996:	83 ec 0c             	sub    $0xc,%esp
 999:	ff 75 ec             	push   -0x14(%ebp)
 99c:	e8 c1 fe ff ff       	call   862 <morecore>
 9a1:	83 c4 10             	add    $0x10,%esp
 9a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
 9a7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 9ab:	75 07                	jne    9b4 <malloc+0xe2>
        return 0;
 9ad:	b8 00 00 00 00       	mov    $0x0,%eax
 9b2:	eb 13                	jmp    9c7 <malloc+0xf5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9b7:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9bd:	8b 00                	mov    (%eax),%eax
 9bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 9c2:	e9 6b ff ff ff       	jmp    932 <malloc+0x60>
  }
}
 9c7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 9ca:	c9                   	leave  
 9cb:	c3                   	ret    

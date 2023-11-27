
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	56                   	push   %esi
   e:	53                   	push   %ebx
   f:	51                   	push   %ecx
  10:	83 ec 1c             	sub    $0x1c,%esp
  13:	e8 68 00 00 00       	call   80 <__x86.get_pc_thunk.bx>
  18:	81 c3 90 0b 00 00    	add    $0xb90,%ebx
  1e:	89 ce                	mov    %ecx,%esi
  int i;

  if(argc < 2){
  20:	83 3e 01             	cmpl   $0x1,(%esi)
  23:	7f 19                	jg     3e <main+0x3e>
    printf(2, "usage: kill pid...\n");
  25:	83 ec 08             	sub    $0x8,%esp
  28:	8d 83 40 fd ff ff    	lea    -0x2c0(%ebx),%eax
  2e:	50                   	push   %eax
  2f:	6a 02                	push   $0x2
  31:	e8 b3 04 00 00       	call   4e9 <printf>
  36:	83 c4 10             	add    $0x10,%esp
    exit();
  39:	e8 0f 03 00 00       	call   34d <exit>
  }
  for(i=1; i<argc; i++)
  3e:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
  45:	eb 2d                	jmp    74 <main+0x74>
    kill(atoi(argv[i]));
  47:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  4a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  51:	8b 46 04             	mov    0x4(%esi),%eax
  54:	01 d0                	add    %edx,%eax
  56:	8b 00                	mov    (%eax),%eax
  58:	83 ec 0c             	sub    $0xc,%esp
  5b:	50                   	push   %eax
  5c:	e8 42 02 00 00       	call   2a3 <atoi>
  61:	83 c4 10             	add    $0x10,%esp
  64:	83 ec 0c             	sub    $0xc,%esp
  67:	50                   	push   %eax
  68:	e8 10 03 00 00       	call   37d <kill>
  6d:	83 c4 10             	add    $0x10,%esp
  for(i=1; i<argc; i++)
  70:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
  74:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  77:	3b 06                	cmp    (%esi),%eax
  79:	7c cc                	jl     47 <main+0x47>
  exit();
  7b:	e8 cd 02 00 00       	call   34d <exit>

00000080 <__x86.get_pc_thunk.bx>:
  80:	8b 1c 24             	mov    (%esp),%ebx
  83:	c3                   	ret    

00000084 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  84:	55                   	push   %ebp
  85:	89 e5                	mov    %esp,%ebp
  87:	57                   	push   %edi
  88:	53                   	push   %ebx
  89:	e8 b3 02 00 00       	call   341 <__x86.get_pc_thunk.ax>
  8e:	05 1a 0b 00 00       	add    $0xb1a,%eax
  asm volatile("cld; rep stosb" :
  93:	8b 4d 08             	mov    0x8(%ebp),%ecx
  96:	8b 55 10             	mov    0x10(%ebp),%edx
  99:	8b 45 0c             	mov    0xc(%ebp),%eax
  9c:	89 cb                	mov    %ecx,%ebx
  9e:	89 df                	mov    %ebx,%edi
  a0:	89 d1                	mov    %edx,%ecx
  a2:	fc                   	cld    
  a3:	f3 aa                	rep stos %al,%es:(%edi)
  a5:	89 ca                	mov    %ecx,%edx
  a7:	89 fb                	mov    %edi,%ebx
  a9:	89 5d 08             	mov    %ebx,0x8(%ebp)
  ac:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  af:	90                   	nop
  b0:	5b                   	pop    %ebx
  b1:	5f                   	pop    %edi
  b2:	5d                   	pop    %ebp
  b3:	c3                   	ret    

000000b4 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  b4:	55                   	push   %ebp
  b5:	89 e5                	mov    %esp,%ebp
  b7:	83 ec 10             	sub    $0x10,%esp
  ba:	e8 82 02 00 00       	call   341 <__x86.get_pc_thunk.ax>
  bf:	05 e9 0a 00 00       	add    $0xae9,%eax
  char *os;

  os = s;
  c4:	8b 45 08             	mov    0x8(%ebp),%eax
  c7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  ca:	90                   	nop
  cb:	8b 55 0c             	mov    0xc(%ebp),%edx
  ce:	8d 42 01             	lea    0x1(%edx),%eax
  d1:	89 45 0c             	mov    %eax,0xc(%ebp)
  d4:	8b 45 08             	mov    0x8(%ebp),%eax
  d7:	8d 48 01             	lea    0x1(%eax),%ecx
  da:	89 4d 08             	mov    %ecx,0x8(%ebp)
  dd:	0f b6 12             	movzbl (%edx),%edx
  e0:	88 10                	mov    %dl,(%eax)
  e2:	0f b6 00             	movzbl (%eax),%eax
  e5:	84 c0                	test   %al,%al
  e7:	75 e2                	jne    cb <strcpy+0x17>
    ;
  return os;
  e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  ec:	c9                   	leave  
  ed:	c3                   	ret    

000000ee <strcmp>:

int
strcmp(const char *p, const char *q)
{
  ee:	55                   	push   %ebp
  ef:	89 e5                	mov    %esp,%ebp
  f1:	e8 4b 02 00 00       	call   341 <__x86.get_pc_thunk.ax>
  f6:	05 b2 0a 00 00       	add    $0xab2,%eax
  while(*p && *p == *q)
  fb:	eb 08                	jmp    105 <strcmp+0x17>
    p++, q++;
  fd:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 101:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 105:	8b 45 08             	mov    0x8(%ebp),%eax
 108:	0f b6 00             	movzbl (%eax),%eax
 10b:	84 c0                	test   %al,%al
 10d:	74 10                	je     11f <strcmp+0x31>
 10f:	8b 45 08             	mov    0x8(%ebp),%eax
 112:	0f b6 10             	movzbl (%eax),%edx
 115:	8b 45 0c             	mov    0xc(%ebp),%eax
 118:	0f b6 00             	movzbl (%eax),%eax
 11b:	38 c2                	cmp    %al,%dl
 11d:	74 de                	je     fd <strcmp+0xf>
  return (uchar)*p - (uchar)*q;
 11f:	8b 45 08             	mov    0x8(%ebp),%eax
 122:	0f b6 00             	movzbl (%eax),%eax
 125:	0f b6 d0             	movzbl %al,%edx
 128:	8b 45 0c             	mov    0xc(%ebp),%eax
 12b:	0f b6 00             	movzbl (%eax),%eax
 12e:	0f b6 c8             	movzbl %al,%ecx
 131:	89 d0                	mov    %edx,%eax
 133:	29 c8                	sub    %ecx,%eax
}
 135:	5d                   	pop    %ebp
 136:	c3                   	ret    

00000137 <strlen>:

uint
strlen(const char *s)
{
 137:	55                   	push   %ebp
 138:	89 e5                	mov    %esp,%ebp
 13a:	83 ec 10             	sub    $0x10,%esp
 13d:	e8 ff 01 00 00       	call   341 <__x86.get_pc_thunk.ax>
 142:	05 66 0a 00 00       	add    $0xa66,%eax
  int n;

  for(n = 0; s[n]; n++)
 147:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 14e:	eb 04                	jmp    154 <strlen+0x1d>
 150:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 154:	8b 55 fc             	mov    -0x4(%ebp),%edx
 157:	8b 45 08             	mov    0x8(%ebp),%eax
 15a:	01 d0                	add    %edx,%eax
 15c:	0f b6 00             	movzbl (%eax),%eax
 15f:	84 c0                	test   %al,%al
 161:	75 ed                	jne    150 <strlen+0x19>
    ;
  return n;
 163:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 166:	c9                   	leave  
 167:	c3                   	ret    

00000168 <memset>:

void*
memset(void *dst, int c, uint n)
{
 168:	55                   	push   %ebp
 169:	89 e5                	mov    %esp,%ebp
 16b:	e8 d1 01 00 00       	call   341 <__x86.get_pc_thunk.ax>
 170:	05 38 0a 00 00       	add    $0xa38,%eax
  stosb(dst, c, n);
 175:	8b 45 10             	mov    0x10(%ebp),%eax
 178:	50                   	push   %eax
 179:	ff 75 0c             	push   0xc(%ebp)
 17c:	ff 75 08             	push   0x8(%ebp)
 17f:	e8 00 ff ff ff       	call   84 <stosb>
 184:	83 c4 0c             	add    $0xc,%esp
  return dst;
 187:	8b 45 08             	mov    0x8(%ebp),%eax
}
 18a:	c9                   	leave  
 18b:	c3                   	ret    

0000018c <strchr>:

char*
strchr(const char *s, char c)
{
 18c:	55                   	push   %ebp
 18d:	89 e5                	mov    %esp,%ebp
 18f:	83 ec 04             	sub    $0x4,%esp
 192:	e8 aa 01 00 00       	call   341 <__x86.get_pc_thunk.ax>
 197:	05 11 0a 00 00       	add    $0xa11,%eax
 19c:	8b 45 0c             	mov    0xc(%ebp),%eax
 19f:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1a2:	eb 14                	jmp    1b8 <strchr+0x2c>
    if(*s == c)
 1a4:	8b 45 08             	mov    0x8(%ebp),%eax
 1a7:	0f b6 00             	movzbl (%eax),%eax
 1aa:	38 45 fc             	cmp    %al,-0x4(%ebp)
 1ad:	75 05                	jne    1b4 <strchr+0x28>
      return (char*)s;
 1af:	8b 45 08             	mov    0x8(%ebp),%eax
 1b2:	eb 13                	jmp    1c7 <strchr+0x3b>
  for(; *s; s++)
 1b4:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1b8:	8b 45 08             	mov    0x8(%ebp),%eax
 1bb:	0f b6 00             	movzbl (%eax),%eax
 1be:	84 c0                	test   %al,%al
 1c0:	75 e2                	jne    1a4 <strchr+0x18>
  return 0;
 1c2:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1c7:	c9                   	leave  
 1c8:	c3                   	ret    

000001c9 <gets>:

char*
gets(char *buf, int max)
{
 1c9:	55                   	push   %ebp
 1ca:	89 e5                	mov    %esp,%ebp
 1cc:	53                   	push   %ebx
 1cd:	83 ec 14             	sub    $0x14,%esp
 1d0:	e8 ab fe ff ff       	call   80 <__x86.get_pc_thunk.bx>
 1d5:	81 c3 d3 09 00 00    	add    $0x9d3,%ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1db:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1e2:	eb 42                	jmp    226 <gets+0x5d>
    cc = read(0, &c, 1);
 1e4:	83 ec 04             	sub    $0x4,%esp
 1e7:	6a 01                	push   $0x1
 1e9:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1ec:	50                   	push   %eax
 1ed:	6a 00                	push   $0x0
 1ef:	e8 71 01 00 00       	call   365 <read>
 1f4:	83 c4 10             	add    $0x10,%esp
 1f7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1fa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1fe:	7e 33                	jle    233 <gets+0x6a>
      break;
    buf[i++] = c;
 200:	8b 45 f4             	mov    -0xc(%ebp),%eax
 203:	8d 50 01             	lea    0x1(%eax),%edx
 206:	89 55 f4             	mov    %edx,-0xc(%ebp)
 209:	89 c2                	mov    %eax,%edx
 20b:	8b 45 08             	mov    0x8(%ebp),%eax
 20e:	01 c2                	add    %eax,%edx
 210:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 214:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 216:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 21a:	3c 0a                	cmp    $0xa,%al
 21c:	74 16                	je     234 <gets+0x6b>
 21e:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 222:	3c 0d                	cmp    $0xd,%al
 224:	74 0e                	je     234 <gets+0x6b>
  for(i=0; i+1 < max; ){
 226:	8b 45 f4             	mov    -0xc(%ebp),%eax
 229:	83 c0 01             	add    $0x1,%eax
 22c:	39 45 0c             	cmp    %eax,0xc(%ebp)
 22f:	7f b3                	jg     1e4 <gets+0x1b>
 231:	eb 01                	jmp    234 <gets+0x6b>
      break;
 233:	90                   	nop
      break;
  }
  buf[i] = '\0';
 234:	8b 55 f4             	mov    -0xc(%ebp),%edx
 237:	8b 45 08             	mov    0x8(%ebp),%eax
 23a:	01 d0                	add    %edx,%eax
 23c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 23f:	8b 45 08             	mov    0x8(%ebp),%eax
}
 242:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 245:	c9                   	leave  
 246:	c3                   	ret    

00000247 <stat>:

int
stat(const char *n, struct stat *st)
{
 247:	55                   	push   %ebp
 248:	89 e5                	mov    %esp,%ebp
 24a:	53                   	push   %ebx
 24b:	83 ec 14             	sub    $0x14,%esp
 24e:	e8 2d fe ff ff       	call   80 <__x86.get_pc_thunk.bx>
 253:	81 c3 55 09 00 00    	add    $0x955,%ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 259:	83 ec 08             	sub    $0x8,%esp
 25c:	6a 00                	push   $0x0
 25e:	ff 75 08             	push   0x8(%ebp)
 261:	e8 27 01 00 00       	call   38d <open>
 266:	83 c4 10             	add    $0x10,%esp
 269:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 26c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 270:	79 07                	jns    279 <stat+0x32>
    return -1;
 272:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 277:	eb 25                	jmp    29e <stat+0x57>
  r = fstat(fd, st);
 279:	83 ec 08             	sub    $0x8,%esp
 27c:	ff 75 0c             	push   0xc(%ebp)
 27f:	ff 75 f4             	push   -0xc(%ebp)
 282:	e8 1e 01 00 00       	call   3a5 <fstat>
 287:	83 c4 10             	add    $0x10,%esp
 28a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 28d:	83 ec 0c             	sub    $0xc,%esp
 290:	ff 75 f4             	push   -0xc(%ebp)
 293:	e8 dd 00 00 00       	call   375 <close>
 298:	83 c4 10             	add    $0x10,%esp
  return r;
 29b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 29e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2a1:	c9                   	leave  
 2a2:	c3                   	ret    

000002a3 <atoi>:

int
atoi(const char *s)
{
 2a3:	55                   	push   %ebp
 2a4:	89 e5                	mov    %esp,%ebp
 2a6:	83 ec 10             	sub    $0x10,%esp
 2a9:	e8 93 00 00 00       	call   341 <__x86.get_pc_thunk.ax>
 2ae:	05 fa 08 00 00       	add    $0x8fa,%eax
  int n;

  n = 0;
 2b3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2ba:	eb 25                	jmp    2e1 <atoi+0x3e>
    n = n*10 + *s++ - '0';
 2bc:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2bf:	89 d0                	mov    %edx,%eax
 2c1:	c1 e0 02             	shl    $0x2,%eax
 2c4:	01 d0                	add    %edx,%eax
 2c6:	01 c0                	add    %eax,%eax
 2c8:	89 c1                	mov    %eax,%ecx
 2ca:	8b 45 08             	mov    0x8(%ebp),%eax
 2cd:	8d 50 01             	lea    0x1(%eax),%edx
 2d0:	89 55 08             	mov    %edx,0x8(%ebp)
 2d3:	0f b6 00             	movzbl (%eax),%eax
 2d6:	0f be c0             	movsbl %al,%eax
 2d9:	01 c8                	add    %ecx,%eax
 2db:	83 e8 30             	sub    $0x30,%eax
 2de:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2e1:	8b 45 08             	mov    0x8(%ebp),%eax
 2e4:	0f b6 00             	movzbl (%eax),%eax
 2e7:	3c 2f                	cmp    $0x2f,%al
 2e9:	7e 0a                	jle    2f5 <atoi+0x52>
 2eb:	8b 45 08             	mov    0x8(%ebp),%eax
 2ee:	0f b6 00             	movzbl (%eax),%eax
 2f1:	3c 39                	cmp    $0x39,%al
 2f3:	7e c7                	jle    2bc <atoi+0x19>
  return n;
 2f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2f8:	c9                   	leave  
 2f9:	c3                   	ret    

000002fa <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2fa:	55                   	push   %ebp
 2fb:	89 e5                	mov    %esp,%ebp
 2fd:	83 ec 10             	sub    $0x10,%esp
 300:	e8 3c 00 00 00       	call   341 <__x86.get_pc_thunk.ax>
 305:	05 a3 08 00 00       	add    $0x8a3,%eax
  char *dst;
  const char *src;

  dst = vdst;
 30a:	8b 45 08             	mov    0x8(%ebp),%eax
 30d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 310:	8b 45 0c             	mov    0xc(%ebp),%eax
 313:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 316:	eb 17                	jmp    32f <memmove+0x35>
    *dst++ = *src++;
 318:	8b 55 f8             	mov    -0x8(%ebp),%edx
 31b:	8d 42 01             	lea    0x1(%edx),%eax
 31e:	89 45 f8             	mov    %eax,-0x8(%ebp)
 321:	8b 45 fc             	mov    -0x4(%ebp),%eax
 324:	8d 48 01             	lea    0x1(%eax),%ecx
 327:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 32a:	0f b6 12             	movzbl (%edx),%edx
 32d:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 32f:	8b 45 10             	mov    0x10(%ebp),%eax
 332:	8d 50 ff             	lea    -0x1(%eax),%edx
 335:	89 55 10             	mov    %edx,0x10(%ebp)
 338:	85 c0                	test   %eax,%eax
 33a:	7f dc                	jg     318 <memmove+0x1e>
  return vdst;
 33c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 33f:	c9                   	leave  
 340:	c3                   	ret    

00000341 <__x86.get_pc_thunk.ax>:
 341:	8b 04 24             	mov    (%esp),%eax
 344:	c3                   	ret    

00000345 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 345:	b8 01 00 00 00       	mov    $0x1,%eax
 34a:	cd 40                	int    $0x40
 34c:	c3                   	ret    

0000034d <exit>:
SYSCALL(exit)
 34d:	b8 02 00 00 00       	mov    $0x2,%eax
 352:	cd 40                	int    $0x40
 354:	c3                   	ret    

00000355 <wait>:
SYSCALL(wait)
 355:	b8 03 00 00 00       	mov    $0x3,%eax
 35a:	cd 40                	int    $0x40
 35c:	c3                   	ret    

0000035d <pipe>:
SYSCALL(pipe)
 35d:	b8 04 00 00 00       	mov    $0x4,%eax
 362:	cd 40                	int    $0x40
 364:	c3                   	ret    

00000365 <read>:
SYSCALL(read)
 365:	b8 05 00 00 00       	mov    $0x5,%eax
 36a:	cd 40                	int    $0x40
 36c:	c3                   	ret    

0000036d <write>:
SYSCALL(write)
 36d:	b8 10 00 00 00       	mov    $0x10,%eax
 372:	cd 40                	int    $0x40
 374:	c3                   	ret    

00000375 <close>:
SYSCALL(close)
 375:	b8 15 00 00 00       	mov    $0x15,%eax
 37a:	cd 40                	int    $0x40
 37c:	c3                   	ret    

0000037d <kill>:
SYSCALL(kill)
 37d:	b8 06 00 00 00       	mov    $0x6,%eax
 382:	cd 40                	int    $0x40
 384:	c3                   	ret    

00000385 <exec>:
SYSCALL(exec)
 385:	b8 07 00 00 00       	mov    $0x7,%eax
 38a:	cd 40                	int    $0x40
 38c:	c3                   	ret    

0000038d <open>:
SYSCALL(open)
 38d:	b8 0f 00 00 00       	mov    $0xf,%eax
 392:	cd 40                	int    $0x40
 394:	c3                   	ret    

00000395 <mknod>:
SYSCALL(mknod)
 395:	b8 11 00 00 00       	mov    $0x11,%eax
 39a:	cd 40                	int    $0x40
 39c:	c3                   	ret    

0000039d <unlink>:
SYSCALL(unlink)
 39d:	b8 12 00 00 00       	mov    $0x12,%eax
 3a2:	cd 40                	int    $0x40
 3a4:	c3                   	ret    

000003a5 <fstat>:
SYSCALL(fstat)
 3a5:	b8 08 00 00 00       	mov    $0x8,%eax
 3aa:	cd 40                	int    $0x40
 3ac:	c3                   	ret    

000003ad <link>:
SYSCALL(link)
 3ad:	b8 13 00 00 00       	mov    $0x13,%eax
 3b2:	cd 40                	int    $0x40
 3b4:	c3                   	ret    

000003b5 <mkdir>:
SYSCALL(mkdir)
 3b5:	b8 14 00 00 00       	mov    $0x14,%eax
 3ba:	cd 40                	int    $0x40
 3bc:	c3                   	ret    

000003bd <chdir>:
SYSCALL(chdir)
 3bd:	b8 09 00 00 00       	mov    $0x9,%eax
 3c2:	cd 40                	int    $0x40
 3c4:	c3                   	ret    

000003c5 <dup>:
SYSCALL(dup)
 3c5:	b8 0a 00 00 00       	mov    $0xa,%eax
 3ca:	cd 40                	int    $0x40
 3cc:	c3                   	ret    

000003cd <getpid>:
SYSCALL(getpid)
 3cd:	b8 0b 00 00 00       	mov    $0xb,%eax
 3d2:	cd 40                	int    $0x40
 3d4:	c3                   	ret    

000003d5 <sbrk>:
SYSCALL(sbrk)
 3d5:	b8 0c 00 00 00       	mov    $0xc,%eax
 3da:	cd 40                	int    $0x40
 3dc:	c3                   	ret    

000003dd <sleep>:
SYSCALL(sleep)
 3dd:	b8 0d 00 00 00       	mov    $0xd,%eax
 3e2:	cd 40                	int    $0x40
 3e4:	c3                   	ret    

000003e5 <uptime>:
SYSCALL(uptime)
 3e5:	b8 0e 00 00 00       	mov    $0xe,%eax
 3ea:	cd 40                	int    $0x40
 3ec:	c3                   	ret    

000003ed <random>:
SYSCALL(random)
 3ed:	b8 16 00 00 00       	mov    $0x16,%eax
 3f2:	cd 40                	int    $0x40
 3f4:	c3                   	ret    

000003f5 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3f5:	55                   	push   %ebp
 3f6:	89 e5                	mov    %esp,%ebp
 3f8:	53                   	push   %ebx
 3f9:	83 ec 14             	sub    $0x14,%esp
 3fc:	e8 40 ff ff ff       	call   341 <__x86.get_pc_thunk.ax>
 401:	05 a7 07 00 00       	add    $0x7a7,%eax
 406:	8b 55 0c             	mov    0xc(%ebp),%edx
 409:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 40c:	83 ec 04             	sub    $0x4,%esp
 40f:	6a 01                	push   $0x1
 411:	8d 55 f4             	lea    -0xc(%ebp),%edx
 414:	52                   	push   %edx
 415:	ff 75 08             	push   0x8(%ebp)
 418:	89 c3                	mov    %eax,%ebx
 41a:	e8 4e ff ff ff       	call   36d <write>
 41f:	83 c4 10             	add    $0x10,%esp
}
 422:	90                   	nop
 423:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 426:	c9                   	leave  
 427:	c3                   	ret    

00000428 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 428:	55                   	push   %ebp
 429:	89 e5                	mov    %esp,%ebp
 42b:	53                   	push   %ebx
 42c:	83 ec 24             	sub    $0x24,%esp
 42f:	e8 58 02 00 00       	call   68c <__x86.get_pc_thunk.cx>
 434:	81 c1 74 07 00 00    	add    $0x774,%ecx
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 43a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 441:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 445:	74 17                	je     45e <printint+0x36>
 447:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 44b:	79 11                	jns    45e <printint+0x36>
    neg = 1;
 44d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 454:	8b 45 0c             	mov    0xc(%ebp),%eax
 457:	f7 d8                	neg    %eax
 459:	89 45 ec             	mov    %eax,-0x14(%ebp)
 45c:	eb 06                	jmp    464 <printint+0x3c>
  } else {
    x = xx;
 45e:	8b 45 0c             	mov    0xc(%ebp),%eax
 461:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 464:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 46b:	8b 5d 10             	mov    0x10(%ebp),%ebx
 46e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 471:	ba 00 00 00 00       	mov    $0x0,%edx
 476:	f7 f3                	div    %ebx
 478:	89 d3                	mov    %edx,%ebx
 47a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 47d:	8d 50 01             	lea    0x1(%eax),%edx
 480:	89 55 f4             	mov    %edx,-0xc(%ebp)
 483:	0f b6 94 19 0c 00 00 	movzbl 0xc(%ecx,%ebx,1),%edx
 48a:	00 
 48b:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 48f:	8b 5d 10             	mov    0x10(%ebp),%ebx
 492:	8b 45 ec             	mov    -0x14(%ebp),%eax
 495:	ba 00 00 00 00       	mov    $0x0,%edx
 49a:	f7 f3                	div    %ebx
 49c:	89 45 ec             	mov    %eax,-0x14(%ebp)
 49f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4a3:	75 c6                	jne    46b <printint+0x43>
  if(neg)
 4a5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4a9:	74 2d                	je     4d8 <printint+0xb0>
    buf[i++] = '-';
 4ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4ae:	8d 50 01             	lea    0x1(%eax),%edx
 4b1:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4b4:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 4b9:	eb 1d                	jmp    4d8 <printint+0xb0>
    putc(fd, buf[i]);
 4bb:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4be:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4c1:	01 d0                	add    %edx,%eax
 4c3:	0f b6 00             	movzbl (%eax),%eax
 4c6:	0f be c0             	movsbl %al,%eax
 4c9:	83 ec 08             	sub    $0x8,%esp
 4cc:	50                   	push   %eax
 4cd:	ff 75 08             	push   0x8(%ebp)
 4d0:	e8 20 ff ff ff       	call   3f5 <putc>
 4d5:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 4d8:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4dc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4e0:	79 d9                	jns    4bb <printint+0x93>
}
 4e2:	90                   	nop
 4e3:	90                   	nop
 4e4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4e7:	c9                   	leave  
 4e8:	c3                   	ret    

000004e9 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4e9:	55                   	push   %ebp
 4ea:	89 e5                	mov    %esp,%ebp
 4ec:	53                   	push   %ebx
 4ed:	83 ec 24             	sub    $0x24,%esp
 4f0:	e8 8b fb ff ff       	call   80 <__x86.get_pc_thunk.bx>
 4f5:	81 c3 b3 06 00 00    	add    $0x6b3,%ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4fb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 502:	8d 45 0c             	lea    0xc(%ebp),%eax
 505:	83 c0 04             	add    $0x4,%eax
 508:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 50b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 512:	e9 5b 01 00 00       	jmp    672 <printf+0x189>
    c = fmt[i] & 0xff;
 517:	8b 55 0c             	mov    0xc(%ebp),%edx
 51a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 51d:	01 d0                	add    %edx,%eax
 51f:	0f b6 00             	movzbl (%eax),%eax
 522:	0f be c0             	movsbl %al,%eax
 525:	25 ff 00 00 00       	and    $0xff,%eax
 52a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 52d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 531:	75 2c                	jne    55f <printf+0x76>
      if(c == '%'){
 533:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 537:	75 0c                	jne    545 <printf+0x5c>
        state = '%';
 539:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 540:	e9 29 01 00 00       	jmp    66e <printf+0x185>
      } else {
        putc(fd, c);
 545:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 548:	0f be c0             	movsbl %al,%eax
 54b:	83 ec 08             	sub    $0x8,%esp
 54e:	50                   	push   %eax
 54f:	ff 75 08             	push   0x8(%ebp)
 552:	e8 9e fe ff ff       	call   3f5 <putc>
 557:	83 c4 10             	add    $0x10,%esp
 55a:	e9 0f 01 00 00       	jmp    66e <printf+0x185>
      }
    } else if(state == '%'){
 55f:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 563:	0f 85 05 01 00 00    	jne    66e <printf+0x185>
      if(c == 'd'){
 569:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 56d:	75 1e                	jne    58d <printf+0xa4>
        printint(fd, *ap, 10, 1);
 56f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 572:	8b 00                	mov    (%eax),%eax
 574:	6a 01                	push   $0x1
 576:	6a 0a                	push   $0xa
 578:	50                   	push   %eax
 579:	ff 75 08             	push   0x8(%ebp)
 57c:	e8 a7 fe ff ff       	call   428 <printint>
 581:	83 c4 10             	add    $0x10,%esp
        ap++;
 584:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 588:	e9 da 00 00 00       	jmp    667 <printf+0x17e>
      } else if(c == 'x' || c == 'p'){
 58d:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 591:	74 06                	je     599 <printf+0xb0>
 593:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 597:	75 1e                	jne    5b7 <printf+0xce>
        printint(fd, *ap, 16, 0);
 599:	8b 45 e8             	mov    -0x18(%ebp),%eax
 59c:	8b 00                	mov    (%eax),%eax
 59e:	6a 00                	push   $0x0
 5a0:	6a 10                	push   $0x10
 5a2:	50                   	push   %eax
 5a3:	ff 75 08             	push   0x8(%ebp)
 5a6:	e8 7d fe ff ff       	call   428 <printint>
 5ab:	83 c4 10             	add    $0x10,%esp
        ap++;
 5ae:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5b2:	e9 b0 00 00 00       	jmp    667 <printf+0x17e>
      } else if(c == 's'){
 5b7:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5bb:	75 45                	jne    602 <printf+0x119>
        s = (char*)*ap;
 5bd:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5c0:	8b 00                	mov    (%eax),%eax
 5c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5c5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5c9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5cd:	75 27                	jne    5f6 <printf+0x10d>
          s = "(null)";
 5cf:	8d 83 54 fd ff ff    	lea    -0x2ac(%ebx),%eax
 5d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while(*s != 0){
 5d8:	eb 1c                	jmp    5f6 <printf+0x10d>
          putc(fd, *s);
 5da:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5dd:	0f b6 00             	movzbl (%eax),%eax
 5e0:	0f be c0             	movsbl %al,%eax
 5e3:	83 ec 08             	sub    $0x8,%esp
 5e6:	50                   	push   %eax
 5e7:	ff 75 08             	push   0x8(%ebp)
 5ea:	e8 06 fe ff ff       	call   3f5 <putc>
 5ef:	83 c4 10             	add    $0x10,%esp
          s++;
 5f2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 5f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5f9:	0f b6 00             	movzbl (%eax),%eax
 5fc:	84 c0                	test   %al,%al
 5fe:	75 da                	jne    5da <printf+0xf1>
 600:	eb 65                	jmp    667 <printf+0x17e>
        }
      } else if(c == 'c'){
 602:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 606:	75 1d                	jne    625 <printf+0x13c>
        putc(fd, *ap);
 608:	8b 45 e8             	mov    -0x18(%ebp),%eax
 60b:	8b 00                	mov    (%eax),%eax
 60d:	0f be c0             	movsbl %al,%eax
 610:	83 ec 08             	sub    $0x8,%esp
 613:	50                   	push   %eax
 614:	ff 75 08             	push   0x8(%ebp)
 617:	e8 d9 fd ff ff       	call   3f5 <putc>
 61c:	83 c4 10             	add    $0x10,%esp
        ap++;
 61f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 623:	eb 42                	jmp    667 <printf+0x17e>
      } else if(c == '%'){
 625:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 629:	75 17                	jne    642 <printf+0x159>
        putc(fd, c);
 62b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 62e:	0f be c0             	movsbl %al,%eax
 631:	83 ec 08             	sub    $0x8,%esp
 634:	50                   	push   %eax
 635:	ff 75 08             	push   0x8(%ebp)
 638:	e8 b8 fd ff ff       	call   3f5 <putc>
 63d:	83 c4 10             	add    $0x10,%esp
 640:	eb 25                	jmp    667 <printf+0x17e>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 642:	83 ec 08             	sub    $0x8,%esp
 645:	6a 25                	push   $0x25
 647:	ff 75 08             	push   0x8(%ebp)
 64a:	e8 a6 fd ff ff       	call   3f5 <putc>
 64f:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 652:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 655:	0f be c0             	movsbl %al,%eax
 658:	83 ec 08             	sub    $0x8,%esp
 65b:	50                   	push   %eax
 65c:	ff 75 08             	push   0x8(%ebp)
 65f:	e8 91 fd ff ff       	call   3f5 <putc>
 664:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 667:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 66e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 672:	8b 55 0c             	mov    0xc(%ebp),%edx
 675:	8b 45 f0             	mov    -0x10(%ebp),%eax
 678:	01 d0                	add    %edx,%eax
 67a:	0f b6 00             	movzbl (%eax),%eax
 67d:	84 c0                	test   %al,%al
 67f:	0f 85 92 fe ff ff    	jne    517 <printf+0x2e>
    }
  }
}
 685:	90                   	nop
 686:	90                   	nop
 687:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 68a:	c9                   	leave  
 68b:	c3                   	ret    

0000068c <__x86.get_pc_thunk.cx>:
 68c:	8b 0c 24             	mov    (%esp),%ecx
 68f:	c3                   	ret    

00000690 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 690:	55                   	push   %ebp
 691:	89 e5                	mov    %esp,%ebp
 693:	83 ec 10             	sub    $0x10,%esp
 696:	e8 a6 fc ff ff       	call   341 <__x86.get_pc_thunk.ax>
 69b:	05 0d 05 00 00       	add    $0x50d,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6a0:	8b 55 08             	mov    0x8(%ebp),%edx
 6a3:	83 ea 08             	sub    $0x8,%edx
 6a6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a9:	8b 90 28 00 00 00    	mov    0x28(%eax),%edx
 6af:	89 55 fc             	mov    %edx,-0x4(%ebp)
 6b2:	eb 24                	jmp    6d8 <free+0x48>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6b4:	8b 55 fc             	mov    -0x4(%ebp),%edx
 6b7:	8b 12                	mov    (%edx),%edx
 6b9:	39 55 fc             	cmp    %edx,-0x4(%ebp)
 6bc:	72 12                	jb     6d0 <free+0x40>
 6be:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6c1:	3b 55 fc             	cmp    -0x4(%ebp),%edx
 6c4:	77 24                	ja     6ea <free+0x5a>
 6c6:	8b 55 fc             	mov    -0x4(%ebp),%edx
 6c9:	8b 12                	mov    (%edx),%edx
 6cb:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 6ce:	72 1a                	jb     6ea <free+0x5a>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d0:	8b 55 fc             	mov    -0x4(%ebp),%edx
 6d3:	8b 12                	mov    (%edx),%edx
 6d5:	89 55 fc             	mov    %edx,-0x4(%ebp)
 6d8:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6db:	3b 55 fc             	cmp    -0x4(%ebp),%edx
 6de:	76 d4                	jbe    6b4 <free+0x24>
 6e0:	8b 55 fc             	mov    -0x4(%ebp),%edx
 6e3:	8b 12                	mov    (%edx),%edx
 6e5:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 6e8:	73 ca                	jae    6b4 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6ea:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6ed:	8b 52 04             	mov    0x4(%edx),%edx
 6f0:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
 6f7:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6fa:	01 d1                	add    %edx,%ecx
 6fc:	8b 55 fc             	mov    -0x4(%ebp),%edx
 6ff:	8b 12                	mov    (%edx),%edx
 701:	39 d1                	cmp    %edx,%ecx
 703:	75 24                	jne    729 <free+0x99>
    bp->s.size += p->s.ptr->s.size;
 705:	8b 55 f8             	mov    -0x8(%ebp),%edx
 708:	8b 4a 04             	mov    0x4(%edx),%ecx
 70b:	8b 55 fc             	mov    -0x4(%ebp),%edx
 70e:	8b 12                	mov    (%edx),%edx
 710:	8b 52 04             	mov    0x4(%edx),%edx
 713:	01 d1                	add    %edx,%ecx
 715:	8b 55 f8             	mov    -0x8(%ebp),%edx
 718:	89 4a 04             	mov    %ecx,0x4(%edx)
    bp->s.ptr = p->s.ptr->s.ptr;
 71b:	8b 55 fc             	mov    -0x4(%ebp),%edx
 71e:	8b 12                	mov    (%edx),%edx
 720:	8b 0a                	mov    (%edx),%ecx
 722:	8b 55 f8             	mov    -0x8(%ebp),%edx
 725:	89 0a                	mov    %ecx,(%edx)
 727:	eb 0a                	jmp    733 <free+0xa3>
  } else
    bp->s.ptr = p->s.ptr;
 729:	8b 55 fc             	mov    -0x4(%ebp),%edx
 72c:	8b 0a                	mov    (%edx),%ecx
 72e:	8b 55 f8             	mov    -0x8(%ebp),%edx
 731:	89 0a                	mov    %ecx,(%edx)
  if(p + p->s.size == bp){
 733:	8b 55 fc             	mov    -0x4(%ebp),%edx
 736:	8b 52 04             	mov    0x4(%edx),%edx
 739:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
 740:	8b 55 fc             	mov    -0x4(%ebp),%edx
 743:	01 ca                	add    %ecx,%edx
 745:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 748:	75 20                	jne    76a <free+0xda>
    p->s.size += bp->s.size;
 74a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 74d:	8b 4a 04             	mov    0x4(%edx),%ecx
 750:	8b 55 f8             	mov    -0x8(%ebp),%edx
 753:	8b 52 04             	mov    0x4(%edx),%edx
 756:	01 d1                	add    %edx,%ecx
 758:	8b 55 fc             	mov    -0x4(%ebp),%edx
 75b:	89 4a 04             	mov    %ecx,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 75e:	8b 55 f8             	mov    -0x8(%ebp),%edx
 761:	8b 0a                	mov    (%edx),%ecx
 763:	8b 55 fc             	mov    -0x4(%ebp),%edx
 766:	89 0a                	mov    %ecx,(%edx)
 768:	eb 08                	jmp    772 <free+0xe2>
  } else
    p->s.ptr = bp;
 76a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 76d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
 770:	89 0a                	mov    %ecx,(%edx)
  freep = p;
 772:	8b 55 fc             	mov    -0x4(%ebp),%edx
 775:	89 90 28 00 00 00    	mov    %edx,0x28(%eax)
}
 77b:	90                   	nop
 77c:	c9                   	leave  
 77d:	c3                   	ret    

0000077e <morecore>:

static Header*
morecore(uint nu)
{
 77e:	55                   	push   %ebp
 77f:	89 e5                	mov    %esp,%ebp
 781:	53                   	push   %ebx
 782:	83 ec 14             	sub    $0x14,%esp
 785:	e8 f6 f8 ff ff       	call   80 <__x86.get_pc_thunk.bx>
 78a:	81 c3 1e 04 00 00    	add    $0x41e,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 790:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 797:	77 07                	ja     7a0 <morecore+0x22>
    nu = 4096;
 799:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7a0:	8b 45 08             	mov    0x8(%ebp),%eax
 7a3:	c1 e0 03             	shl    $0x3,%eax
 7a6:	83 ec 0c             	sub    $0xc,%esp
 7a9:	50                   	push   %eax
 7aa:	e8 26 fc ff ff       	call   3d5 <sbrk>
 7af:	83 c4 10             	add    $0x10,%esp
 7b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 7b5:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 7b9:	75 07                	jne    7c2 <morecore+0x44>
    return 0;
 7bb:	b8 00 00 00 00       	mov    $0x0,%eax
 7c0:	eb 27                	jmp    7e9 <morecore+0x6b>
  hp = (Header*)p;
 7c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 7c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7cb:	8b 55 08             	mov    0x8(%ebp),%edx
 7ce:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7d4:	83 c0 08             	add    $0x8,%eax
 7d7:	83 ec 0c             	sub    $0xc,%esp
 7da:	50                   	push   %eax
 7db:	e8 b0 fe ff ff       	call   690 <free>
 7e0:	83 c4 10             	add    $0x10,%esp
  return freep;
 7e3:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
}
 7e9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 7ec:	c9                   	leave  
 7ed:	c3                   	ret    

000007ee <malloc>:

void*
malloc(uint nbytes)
{
 7ee:	55                   	push   %ebp
 7ef:	89 e5                	mov    %esp,%ebp
 7f1:	53                   	push   %ebx
 7f2:	83 ec 14             	sub    $0x14,%esp
 7f5:	e8 86 f8 ff ff       	call   80 <__x86.get_pc_thunk.bx>
 7fa:	81 c3 ae 03 00 00    	add    $0x3ae,%ebx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 800:	8b 45 08             	mov    0x8(%ebp),%eax
 803:	83 c0 07             	add    $0x7,%eax
 806:	c1 e8 03             	shr    $0x3,%eax
 809:	83 c0 01             	add    $0x1,%eax
 80c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 80f:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
 815:	89 45 f0             	mov    %eax,-0x10(%ebp)
 818:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 81c:	75 28                	jne    846 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
 81e:	8d 83 20 00 00 00    	lea    0x20(%ebx),%eax
 824:	89 45 f0             	mov    %eax,-0x10(%ebp)
 827:	8b 45 f0             	mov    -0x10(%ebp),%eax
 82a:	89 83 28 00 00 00    	mov    %eax,0x28(%ebx)
 830:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
 836:	89 83 20 00 00 00    	mov    %eax,0x20(%ebx)
    base.s.size = 0;
 83c:	c7 83 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
 843:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 846:	8b 45 f0             	mov    -0x10(%ebp),%eax
 849:	8b 00                	mov    (%eax),%eax
 84b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 84e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 851:	8b 40 04             	mov    0x4(%eax),%eax
 854:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 857:	77 4e                	ja     8a7 <malloc+0xb9>
      if(p->s.size == nunits)
 859:	8b 45 f4             	mov    -0xc(%ebp),%eax
 85c:	8b 40 04             	mov    0x4(%eax),%eax
 85f:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 862:	75 0c                	jne    870 <malloc+0x82>
        prevp->s.ptr = p->s.ptr;
 864:	8b 45 f4             	mov    -0xc(%ebp),%eax
 867:	8b 10                	mov    (%eax),%edx
 869:	8b 45 f0             	mov    -0x10(%ebp),%eax
 86c:	89 10                	mov    %edx,(%eax)
 86e:	eb 26                	jmp    896 <malloc+0xa8>
      else {
        p->s.size -= nunits;
 870:	8b 45 f4             	mov    -0xc(%ebp),%eax
 873:	8b 40 04             	mov    0x4(%eax),%eax
 876:	2b 45 ec             	sub    -0x14(%ebp),%eax
 879:	89 c2                	mov    %eax,%edx
 87b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 87e:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 881:	8b 45 f4             	mov    -0xc(%ebp),%eax
 884:	8b 40 04             	mov    0x4(%eax),%eax
 887:	c1 e0 03             	shl    $0x3,%eax
 88a:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 88d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 890:	8b 55 ec             	mov    -0x14(%ebp),%edx
 893:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 896:	8b 45 f0             	mov    -0x10(%ebp),%eax
 899:	89 83 28 00 00 00    	mov    %eax,0x28(%ebx)
      return (void*)(p + 1);
 89f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a2:	83 c0 08             	add    $0x8,%eax
 8a5:	eb 3c                	jmp    8e3 <malloc+0xf5>
    }
    if(p == freep)
 8a7:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
 8ad:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8b0:	75 1e                	jne    8d0 <malloc+0xe2>
      if((p = morecore(nunits)) == 0)
 8b2:	83 ec 0c             	sub    $0xc,%esp
 8b5:	ff 75 ec             	push   -0x14(%ebp)
 8b8:	e8 c1 fe ff ff       	call   77e <morecore>
 8bd:	83 c4 10             	add    $0x10,%esp
 8c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8c3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8c7:	75 07                	jne    8d0 <malloc+0xe2>
        return 0;
 8c9:	b8 00 00 00 00       	mov    $0x0,%eax
 8ce:	eb 13                	jmp    8e3 <malloc+0xf5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8d9:	8b 00                	mov    (%eax),%eax
 8db:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 8de:	e9 6b ff ff ff       	jmp    84e <malloc+0x60>
  }
}
 8e3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 8e6:	c9                   	leave  
 8e7:	c3                   	ret    

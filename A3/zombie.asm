
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
   f:	e8 21 00 00 00       	call   35 <__x86.get_pc_thunk.bx>
  14:	81 c3 30 0b 00 00    	add    $0xb30,%ebx
  if(fork() > 0)
  1a:	e8 db 02 00 00       	call   2fa <fork>
  1f:	85 c0                	test   %eax,%eax
  21:	7e 0d                	jle    30 <main+0x30>
    sleep(5);  // Let child exit before parent.
  23:	83 ec 0c             	sub    $0xc,%esp
  26:	6a 05                	push   $0x5
  28:	e8 65 03 00 00       	call   392 <sleep>
  2d:	83 c4 10             	add    $0x10,%esp
  exit();
  30:	e8 cd 02 00 00       	call   302 <exit>

00000035 <__x86.get_pc_thunk.bx>:
  35:	8b 1c 24             	mov    (%esp),%ebx
  38:	c3                   	ret    

00000039 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  39:	55                   	push   %ebp
  3a:	89 e5                	mov    %esp,%ebp
  3c:	57                   	push   %edi
  3d:	53                   	push   %ebx
  3e:	e8 b3 02 00 00       	call   2f6 <__x86.get_pc_thunk.ax>
  43:	05 01 0b 00 00       	add    $0xb01,%eax
  asm volatile("cld; rep stosb" :
  48:	8b 4d 08             	mov    0x8(%ebp),%ecx
  4b:	8b 55 10             	mov    0x10(%ebp),%edx
  4e:	8b 45 0c             	mov    0xc(%ebp),%eax
  51:	89 cb                	mov    %ecx,%ebx
  53:	89 df                	mov    %ebx,%edi
  55:	89 d1                	mov    %edx,%ecx
  57:	fc                   	cld    
  58:	f3 aa                	rep stos %al,%es:(%edi)
  5a:	89 ca                	mov    %ecx,%edx
  5c:	89 fb                	mov    %edi,%ebx
  5e:	89 5d 08             	mov    %ebx,0x8(%ebp)
  61:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  64:	90                   	nop
  65:	5b                   	pop    %ebx
  66:	5f                   	pop    %edi
  67:	5d                   	pop    %ebp
  68:	c3                   	ret    

00000069 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  69:	55                   	push   %ebp
  6a:	89 e5                	mov    %esp,%ebp
  6c:	83 ec 10             	sub    $0x10,%esp
  6f:	e8 82 02 00 00       	call   2f6 <__x86.get_pc_thunk.ax>
  74:	05 d0 0a 00 00       	add    $0xad0,%eax
  char *os;

  os = s;
  79:	8b 45 08             	mov    0x8(%ebp),%eax
  7c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  7f:	90                   	nop
  80:	8b 55 0c             	mov    0xc(%ebp),%edx
  83:	8d 42 01             	lea    0x1(%edx),%eax
  86:	89 45 0c             	mov    %eax,0xc(%ebp)
  89:	8b 45 08             	mov    0x8(%ebp),%eax
  8c:	8d 48 01             	lea    0x1(%eax),%ecx
  8f:	89 4d 08             	mov    %ecx,0x8(%ebp)
  92:	0f b6 12             	movzbl (%edx),%edx
  95:	88 10                	mov    %dl,(%eax)
  97:	0f b6 00             	movzbl (%eax),%eax
  9a:	84 c0                	test   %al,%al
  9c:	75 e2                	jne    80 <strcpy+0x17>
    ;
  return os;
  9e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  a1:	c9                   	leave  
  a2:	c3                   	ret    

000000a3 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  a3:	55                   	push   %ebp
  a4:	89 e5                	mov    %esp,%ebp
  a6:	e8 4b 02 00 00       	call   2f6 <__x86.get_pc_thunk.ax>
  ab:	05 99 0a 00 00       	add    $0xa99,%eax
  while(*p && *p == *q)
  b0:	eb 08                	jmp    ba <strcmp+0x17>
    p++, q++;
  b2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  b6:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
  ba:	8b 45 08             	mov    0x8(%ebp),%eax
  bd:	0f b6 00             	movzbl (%eax),%eax
  c0:	84 c0                	test   %al,%al
  c2:	74 10                	je     d4 <strcmp+0x31>
  c4:	8b 45 08             	mov    0x8(%ebp),%eax
  c7:	0f b6 10             	movzbl (%eax),%edx
  ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  cd:	0f b6 00             	movzbl (%eax),%eax
  d0:	38 c2                	cmp    %al,%dl
  d2:	74 de                	je     b2 <strcmp+0xf>
  return (uchar)*p - (uchar)*q;
  d4:	8b 45 08             	mov    0x8(%ebp),%eax
  d7:	0f b6 00             	movzbl (%eax),%eax
  da:	0f b6 d0             	movzbl %al,%edx
  dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  e0:	0f b6 00             	movzbl (%eax),%eax
  e3:	0f b6 c8             	movzbl %al,%ecx
  e6:	89 d0                	mov    %edx,%eax
  e8:	29 c8                	sub    %ecx,%eax
}
  ea:	5d                   	pop    %ebp
  eb:	c3                   	ret    

000000ec <strlen>:

uint
strlen(const char *s)
{
  ec:	55                   	push   %ebp
  ed:	89 e5                	mov    %esp,%ebp
  ef:	83 ec 10             	sub    $0x10,%esp
  f2:	e8 ff 01 00 00       	call   2f6 <__x86.get_pc_thunk.ax>
  f7:	05 4d 0a 00 00       	add    $0xa4d,%eax
  int n;

  for(n = 0; s[n]; n++)
  fc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 103:	eb 04                	jmp    109 <strlen+0x1d>
 105:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 109:	8b 55 fc             	mov    -0x4(%ebp),%edx
 10c:	8b 45 08             	mov    0x8(%ebp),%eax
 10f:	01 d0                	add    %edx,%eax
 111:	0f b6 00             	movzbl (%eax),%eax
 114:	84 c0                	test   %al,%al
 116:	75 ed                	jne    105 <strlen+0x19>
    ;
  return n;
 118:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 11b:	c9                   	leave  
 11c:	c3                   	ret    

0000011d <memset>:

void*
memset(void *dst, int c, uint n)
{
 11d:	55                   	push   %ebp
 11e:	89 e5                	mov    %esp,%ebp
 120:	e8 d1 01 00 00       	call   2f6 <__x86.get_pc_thunk.ax>
 125:	05 1f 0a 00 00       	add    $0xa1f,%eax
  stosb(dst, c, n);
 12a:	8b 45 10             	mov    0x10(%ebp),%eax
 12d:	50                   	push   %eax
 12e:	ff 75 0c             	push   0xc(%ebp)
 131:	ff 75 08             	push   0x8(%ebp)
 134:	e8 00 ff ff ff       	call   39 <stosb>
 139:	83 c4 0c             	add    $0xc,%esp
  return dst;
 13c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 13f:	c9                   	leave  
 140:	c3                   	ret    

00000141 <strchr>:

char*
strchr(const char *s, char c)
{
 141:	55                   	push   %ebp
 142:	89 e5                	mov    %esp,%ebp
 144:	83 ec 04             	sub    $0x4,%esp
 147:	e8 aa 01 00 00       	call   2f6 <__x86.get_pc_thunk.ax>
 14c:	05 f8 09 00 00       	add    $0x9f8,%eax
 151:	8b 45 0c             	mov    0xc(%ebp),%eax
 154:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 157:	eb 14                	jmp    16d <strchr+0x2c>
    if(*s == c)
 159:	8b 45 08             	mov    0x8(%ebp),%eax
 15c:	0f b6 00             	movzbl (%eax),%eax
 15f:	38 45 fc             	cmp    %al,-0x4(%ebp)
 162:	75 05                	jne    169 <strchr+0x28>
      return (char*)s;
 164:	8b 45 08             	mov    0x8(%ebp),%eax
 167:	eb 13                	jmp    17c <strchr+0x3b>
  for(; *s; s++)
 169:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 16d:	8b 45 08             	mov    0x8(%ebp),%eax
 170:	0f b6 00             	movzbl (%eax),%eax
 173:	84 c0                	test   %al,%al
 175:	75 e2                	jne    159 <strchr+0x18>
  return 0;
 177:	b8 00 00 00 00       	mov    $0x0,%eax
}
 17c:	c9                   	leave  
 17d:	c3                   	ret    

0000017e <gets>:

char*
gets(char *buf, int max)
{
 17e:	55                   	push   %ebp
 17f:	89 e5                	mov    %esp,%ebp
 181:	53                   	push   %ebx
 182:	83 ec 14             	sub    $0x14,%esp
 185:	e8 ab fe ff ff       	call   35 <__x86.get_pc_thunk.bx>
 18a:	81 c3 ba 09 00 00    	add    $0x9ba,%ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 190:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 197:	eb 42                	jmp    1db <gets+0x5d>
    cc = read(0, &c, 1);
 199:	83 ec 04             	sub    $0x4,%esp
 19c:	6a 01                	push   $0x1
 19e:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1a1:	50                   	push   %eax
 1a2:	6a 00                	push   $0x0
 1a4:	e8 71 01 00 00       	call   31a <read>
 1a9:	83 c4 10             	add    $0x10,%esp
 1ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1af:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1b3:	7e 33                	jle    1e8 <gets+0x6a>
      break;
    buf[i++] = c;
 1b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1b8:	8d 50 01             	lea    0x1(%eax),%edx
 1bb:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1be:	89 c2                	mov    %eax,%edx
 1c0:	8b 45 08             	mov    0x8(%ebp),%eax
 1c3:	01 c2                	add    %eax,%edx
 1c5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c9:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1cb:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1cf:	3c 0a                	cmp    $0xa,%al
 1d1:	74 16                	je     1e9 <gets+0x6b>
 1d3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1d7:	3c 0d                	cmp    $0xd,%al
 1d9:	74 0e                	je     1e9 <gets+0x6b>
  for(i=0; i+1 < max; ){
 1db:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1de:	83 c0 01             	add    $0x1,%eax
 1e1:	39 45 0c             	cmp    %eax,0xc(%ebp)
 1e4:	7f b3                	jg     199 <gets+0x1b>
 1e6:	eb 01                	jmp    1e9 <gets+0x6b>
      break;
 1e8:	90                   	nop
      break;
  }
  buf[i] = '\0';
 1e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1ec:	8b 45 08             	mov    0x8(%ebp),%eax
 1ef:	01 d0                	add    %edx,%eax
 1f1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1f4:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1f7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1fa:	c9                   	leave  
 1fb:	c3                   	ret    

000001fc <stat>:

int
stat(const char *n, struct stat *st)
{
 1fc:	55                   	push   %ebp
 1fd:	89 e5                	mov    %esp,%ebp
 1ff:	53                   	push   %ebx
 200:	83 ec 14             	sub    $0x14,%esp
 203:	e8 2d fe ff ff       	call   35 <__x86.get_pc_thunk.bx>
 208:	81 c3 3c 09 00 00    	add    $0x93c,%ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 20e:	83 ec 08             	sub    $0x8,%esp
 211:	6a 00                	push   $0x0
 213:	ff 75 08             	push   0x8(%ebp)
 216:	e8 27 01 00 00       	call   342 <open>
 21b:	83 c4 10             	add    $0x10,%esp
 21e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 221:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 225:	79 07                	jns    22e <stat+0x32>
    return -1;
 227:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 22c:	eb 25                	jmp    253 <stat+0x57>
  r = fstat(fd, st);
 22e:	83 ec 08             	sub    $0x8,%esp
 231:	ff 75 0c             	push   0xc(%ebp)
 234:	ff 75 f4             	push   -0xc(%ebp)
 237:	e8 1e 01 00 00       	call   35a <fstat>
 23c:	83 c4 10             	add    $0x10,%esp
 23f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 242:	83 ec 0c             	sub    $0xc,%esp
 245:	ff 75 f4             	push   -0xc(%ebp)
 248:	e8 dd 00 00 00       	call   32a <close>
 24d:	83 c4 10             	add    $0x10,%esp
  return r;
 250:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 253:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 256:	c9                   	leave  
 257:	c3                   	ret    

00000258 <atoi>:

int
atoi(const char *s)
{
 258:	55                   	push   %ebp
 259:	89 e5                	mov    %esp,%ebp
 25b:	83 ec 10             	sub    $0x10,%esp
 25e:	e8 93 00 00 00       	call   2f6 <__x86.get_pc_thunk.ax>
 263:	05 e1 08 00 00       	add    $0x8e1,%eax
  int n;

  n = 0;
 268:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 26f:	eb 25                	jmp    296 <atoi+0x3e>
    n = n*10 + *s++ - '0';
 271:	8b 55 fc             	mov    -0x4(%ebp),%edx
 274:	89 d0                	mov    %edx,%eax
 276:	c1 e0 02             	shl    $0x2,%eax
 279:	01 d0                	add    %edx,%eax
 27b:	01 c0                	add    %eax,%eax
 27d:	89 c1                	mov    %eax,%ecx
 27f:	8b 45 08             	mov    0x8(%ebp),%eax
 282:	8d 50 01             	lea    0x1(%eax),%edx
 285:	89 55 08             	mov    %edx,0x8(%ebp)
 288:	0f b6 00             	movzbl (%eax),%eax
 28b:	0f be c0             	movsbl %al,%eax
 28e:	01 c8                	add    %ecx,%eax
 290:	83 e8 30             	sub    $0x30,%eax
 293:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 296:	8b 45 08             	mov    0x8(%ebp),%eax
 299:	0f b6 00             	movzbl (%eax),%eax
 29c:	3c 2f                	cmp    $0x2f,%al
 29e:	7e 0a                	jle    2aa <atoi+0x52>
 2a0:	8b 45 08             	mov    0x8(%ebp),%eax
 2a3:	0f b6 00             	movzbl (%eax),%eax
 2a6:	3c 39                	cmp    $0x39,%al
 2a8:	7e c7                	jle    271 <atoi+0x19>
  return n;
 2aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2ad:	c9                   	leave  
 2ae:	c3                   	ret    

000002af <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2af:	55                   	push   %ebp
 2b0:	89 e5                	mov    %esp,%ebp
 2b2:	83 ec 10             	sub    $0x10,%esp
 2b5:	e8 3c 00 00 00       	call   2f6 <__x86.get_pc_thunk.ax>
 2ba:	05 8a 08 00 00       	add    $0x88a,%eax
  char *dst;
  const char *src;

  dst = vdst;
 2bf:	8b 45 08             	mov    0x8(%ebp),%eax
 2c2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2c5:	8b 45 0c             	mov    0xc(%ebp),%eax
 2c8:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2cb:	eb 17                	jmp    2e4 <memmove+0x35>
    *dst++ = *src++;
 2cd:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2d0:	8d 42 01             	lea    0x1(%edx),%eax
 2d3:	89 45 f8             	mov    %eax,-0x8(%ebp)
 2d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2d9:	8d 48 01             	lea    0x1(%eax),%ecx
 2dc:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 2df:	0f b6 12             	movzbl (%edx),%edx
 2e2:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 2e4:	8b 45 10             	mov    0x10(%ebp),%eax
 2e7:	8d 50 ff             	lea    -0x1(%eax),%edx
 2ea:	89 55 10             	mov    %edx,0x10(%ebp)
 2ed:	85 c0                	test   %eax,%eax
 2ef:	7f dc                	jg     2cd <memmove+0x1e>
  return vdst;
 2f1:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2f4:	c9                   	leave  
 2f5:	c3                   	ret    

000002f6 <__x86.get_pc_thunk.ax>:
 2f6:	8b 04 24             	mov    (%esp),%eax
 2f9:	c3                   	ret    

000002fa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2fa:	b8 01 00 00 00       	mov    $0x1,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <exit>:
SYSCALL(exit)
 302:	b8 02 00 00 00       	mov    $0x2,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <wait>:
SYSCALL(wait)
 30a:	b8 03 00 00 00       	mov    $0x3,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <pipe>:
SYSCALL(pipe)
 312:	b8 04 00 00 00       	mov    $0x4,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <read>:
SYSCALL(read)
 31a:	b8 05 00 00 00       	mov    $0x5,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <write>:
SYSCALL(write)
 322:	b8 10 00 00 00       	mov    $0x10,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <close>:
SYSCALL(close)
 32a:	b8 15 00 00 00       	mov    $0x15,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <kill>:
SYSCALL(kill)
 332:	b8 06 00 00 00       	mov    $0x6,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <exec>:
SYSCALL(exec)
 33a:	b8 07 00 00 00       	mov    $0x7,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <open>:
SYSCALL(open)
 342:	b8 0f 00 00 00       	mov    $0xf,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <mknod>:
SYSCALL(mknod)
 34a:	b8 11 00 00 00       	mov    $0x11,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <unlink>:
SYSCALL(unlink)
 352:	b8 12 00 00 00       	mov    $0x12,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <fstat>:
SYSCALL(fstat)
 35a:	b8 08 00 00 00       	mov    $0x8,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <link>:
SYSCALL(link)
 362:	b8 13 00 00 00       	mov    $0x13,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <mkdir>:
SYSCALL(mkdir)
 36a:	b8 14 00 00 00       	mov    $0x14,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <chdir>:
SYSCALL(chdir)
 372:	b8 09 00 00 00       	mov    $0x9,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <dup>:
SYSCALL(dup)
 37a:	b8 0a 00 00 00       	mov    $0xa,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <getpid>:
SYSCALL(getpid)
 382:	b8 0b 00 00 00       	mov    $0xb,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <sbrk>:
SYSCALL(sbrk)
 38a:	b8 0c 00 00 00       	mov    $0xc,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <sleep>:
SYSCALL(sleep)
 392:	b8 0d 00 00 00       	mov    $0xd,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <uptime>:
SYSCALL(uptime)
 39a:	b8 0e 00 00 00       	mov    $0xe,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <random>:
SYSCALL(random)
 3a2:	b8 16 00 00 00       	mov    $0x16,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3aa:	55                   	push   %ebp
 3ab:	89 e5                	mov    %esp,%ebp
 3ad:	53                   	push   %ebx
 3ae:	83 ec 14             	sub    $0x14,%esp
 3b1:	e8 40 ff ff ff       	call   2f6 <__x86.get_pc_thunk.ax>
 3b6:	05 8e 07 00 00       	add    $0x78e,%eax
 3bb:	8b 55 0c             	mov    0xc(%ebp),%edx
 3be:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 3c1:	83 ec 04             	sub    $0x4,%esp
 3c4:	6a 01                	push   $0x1
 3c6:	8d 55 f4             	lea    -0xc(%ebp),%edx
 3c9:	52                   	push   %edx
 3ca:	ff 75 08             	push   0x8(%ebp)
 3cd:	89 c3                	mov    %eax,%ebx
 3cf:	e8 4e ff ff ff       	call   322 <write>
 3d4:	83 c4 10             	add    $0x10,%esp
}
 3d7:	90                   	nop
 3d8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3db:	c9                   	leave  
 3dc:	c3                   	ret    

000003dd <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3dd:	55                   	push   %ebp
 3de:	89 e5                	mov    %esp,%ebp
 3e0:	53                   	push   %ebx
 3e1:	83 ec 24             	sub    $0x24,%esp
 3e4:	e8 58 02 00 00       	call   641 <__x86.get_pc_thunk.cx>
 3e9:	81 c1 5b 07 00 00    	add    $0x75b,%ecx
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3ef:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3f6:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3fa:	74 17                	je     413 <printint+0x36>
 3fc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 400:	79 11                	jns    413 <printint+0x36>
    neg = 1;
 402:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 409:	8b 45 0c             	mov    0xc(%ebp),%eax
 40c:	f7 d8                	neg    %eax
 40e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 411:	eb 06                	jmp    419 <printint+0x3c>
  } else {
    x = xx;
 413:	8b 45 0c             	mov    0xc(%ebp),%eax
 416:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 419:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 420:	8b 5d 10             	mov    0x10(%ebp),%ebx
 423:	8b 45 ec             	mov    -0x14(%ebp),%eax
 426:	ba 00 00 00 00       	mov    $0x0,%edx
 42b:	f7 f3                	div    %ebx
 42d:	89 d3                	mov    %edx,%ebx
 42f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 432:	8d 50 01             	lea    0x1(%eax),%edx
 435:	89 55 f4             	mov    %edx,-0xc(%ebp)
 438:	0f b6 94 19 0c 00 00 	movzbl 0xc(%ecx,%ebx,1),%edx
 43f:	00 
 440:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 444:	8b 5d 10             	mov    0x10(%ebp),%ebx
 447:	8b 45 ec             	mov    -0x14(%ebp),%eax
 44a:	ba 00 00 00 00       	mov    $0x0,%edx
 44f:	f7 f3                	div    %ebx
 451:	89 45 ec             	mov    %eax,-0x14(%ebp)
 454:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 458:	75 c6                	jne    420 <printint+0x43>
  if(neg)
 45a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 45e:	74 2d                	je     48d <printint+0xb0>
    buf[i++] = '-';
 460:	8b 45 f4             	mov    -0xc(%ebp),%eax
 463:	8d 50 01             	lea    0x1(%eax),%edx
 466:	89 55 f4             	mov    %edx,-0xc(%ebp)
 469:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 46e:	eb 1d                	jmp    48d <printint+0xb0>
    putc(fd, buf[i]);
 470:	8d 55 dc             	lea    -0x24(%ebp),%edx
 473:	8b 45 f4             	mov    -0xc(%ebp),%eax
 476:	01 d0                	add    %edx,%eax
 478:	0f b6 00             	movzbl (%eax),%eax
 47b:	0f be c0             	movsbl %al,%eax
 47e:	83 ec 08             	sub    $0x8,%esp
 481:	50                   	push   %eax
 482:	ff 75 08             	push   0x8(%ebp)
 485:	e8 20 ff ff ff       	call   3aa <putc>
 48a:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 48d:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 491:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 495:	79 d9                	jns    470 <printint+0x93>
}
 497:	90                   	nop
 498:	90                   	nop
 499:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 49c:	c9                   	leave  
 49d:	c3                   	ret    

0000049e <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 49e:	55                   	push   %ebp
 49f:	89 e5                	mov    %esp,%ebp
 4a1:	53                   	push   %ebx
 4a2:	83 ec 24             	sub    $0x24,%esp
 4a5:	e8 8b fb ff ff       	call   35 <__x86.get_pc_thunk.bx>
 4aa:	81 c3 9a 06 00 00    	add    $0x69a,%ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4b0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4b7:	8d 45 0c             	lea    0xc(%ebp),%eax
 4ba:	83 c0 04             	add    $0x4,%eax
 4bd:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4c0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4c7:	e9 5b 01 00 00       	jmp    627 <printf+0x189>
    c = fmt[i] & 0xff;
 4cc:	8b 55 0c             	mov    0xc(%ebp),%edx
 4cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4d2:	01 d0                	add    %edx,%eax
 4d4:	0f b6 00             	movzbl (%eax),%eax
 4d7:	0f be c0             	movsbl %al,%eax
 4da:	25 ff 00 00 00       	and    $0xff,%eax
 4df:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4e2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4e6:	75 2c                	jne    514 <printf+0x76>
      if(c == '%'){
 4e8:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4ec:	75 0c                	jne    4fa <printf+0x5c>
        state = '%';
 4ee:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4f5:	e9 29 01 00 00       	jmp    623 <printf+0x185>
      } else {
        putc(fd, c);
 4fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4fd:	0f be c0             	movsbl %al,%eax
 500:	83 ec 08             	sub    $0x8,%esp
 503:	50                   	push   %eax
 504:	ff 75 08             	push   0x8(%ebp)
 507:	e8 9e fe ff ff       	call   3aa <putc>
 50c:	83 c4 10             	add    $0x10,%esp
 50f:	e9 0f 01 00 00       	jmp    623 <printf+0x185>
      }
    } else if(state == '%'){
 514:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 518:	0f 85 05 01 00 00    	jne    623 <printf+0x185>
      if(c == 'd'){
 51e:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 522:	75 1e                	jne    542 <printf+0xa4>
        printint(fd, *ap, 10, 1);
 524:	8b 45 e8             	mov    -0x18(%ebp),%eax
 527:	8b 00                	mov    (%eax),%eax
 529:	6a 01                	push   $0x1
 52b:	6a 0a                	push   $0xa
 52d:	50                   	push   %eax
 52e:	ff 75 08             	push   0x8(%ebp)
 531:	e8 a7 fe ff ff       	call   3dd <printint>
 536:	83 c4 10             	add    $0x10,%esp
        ap++;
 539:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 53d:	e9 da 00 00 00       	jmp    61c <printf+0x17e>
      } else if(c == 'x' || c == 'p'){
 542:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 546:	74 06                	je     54e <printf+0xb0>
 548:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 54c:	75 1e                	jne    56c <printf+0xce>
        printint(fd, *ap, 16, 0);
 54e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 551:	8b 00                	mov    (%eax),%eax
 553:	6a 00                	push   $0x0
 555:	6a 10                	push   $0x10
 557:	50                   	push   %eax
 558:	ff 75 08             	push   0x8(%ebp)
 55b:	e8 7d fe ff ff       	call   3dd <printint>
 560:	83 c4 10             	add    $0x10,%esp
        ap++;
 563:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 567:	e9 b0 00 00 00       	jmp    61c <printf+0x17e>
      } else if(c == 's'){
 56c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 570:	75 45                	jne    5b7 <printf+0x119>
        s = (char*)*ap;
 572:	8b 45 e8             	mov    -0x18(%ebp),%eax
 575:	8b 00                	mov    (%eax),%eax
 577:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 57a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 57e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 582:	75 27                	jne    5ab <printf+0x10d>
          s = "(null)";
 584:	8d 83 59 fd ff ff    	lea    -0x2a7(%ebx),%eax
 58a:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while(*s != 0){
 58d:	eb 1c                	jmp    5ab <printf+0x10d>
          putc(fd, *s);
 58f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 592:	0f b6 00             	movzbl (%eax),%eax
 595:	0f be c0             	movsbl %al,%eax
 598:	83 ec 08             	sub    $0x8,%esp
 59b:	50                   	push   %eax
 59c:	ff 75 08             	push   0x8(%ebp)
 59f:	e8 06 fe ff ff       	call   3aa <putc>
 5a4:	83 c4 10             	add    $0x10,%esp
          s++;
 5a7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 5ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5ae:	0f b6 00             	movzbl (%eax),%eax
 5b1:	84 c0                	test   %al,%al
 5b3:	75 da                	jne    58f <printf+0xf1>
 5b5:	eb 65                	jmp    61c <printf+0x17e>
        }
      } else if(c == 'c'){
 5b7:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5bb:	75 1d                	jne    5da <printf+0x13c>
        putc(fd, *ap);
 5bd:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5c0:	8b 00                	mov    (%eax),%eax
 5c2:	0f be c0             	movsbl %al,%eax
 5c5:	83 ec 08             	sub    $0x8,%esp
 5c8:	50                   	push   %eax
 5c9:	ff 75 08             	push   0x8(%ebp)
 5cc:	e8 d9 fd ff ff       	call   3aa <putc>
 5d1:	83 c4 10             	add    $0x10,%esp
        ap++;
 5d4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5d8:	eb 42                	jmp    61c <printf+0x17e>
      } else if(c == '%'){
 5da:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5de:	75 17                	jne    5f7 <printf+0x159>
        putc(fd, c);
 5e0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5e3:	0f be c0             	movsbl %al,%eax
 5e6:	83 ec 08             	sub    $0x8,%esp
 5e9:	50                   	push   %eax
 5ea:	ff 75 08             	push   0x8(%ebp)
 5ed:	e8 b8 fd ff ff       	call   3aa <putc>
 5f2:	83 c4 10             	add    $0x10,%esp
 5f5:	eb 25                	jmp    61c <printf+0x17e>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5f7:	83 ec 08             	sub    $0x8,%esp
 5fa:	6a 25                	push   $0x25
 5fc:	ff 75 08             	push   0x8(%ebp)
 5ff:	e8 a6 fd ff ff       	call   3aa <putc>
 604:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 607:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 60a:	0f be c0             	movsbl %al,%eax
 60d:	83 ec 08             	sub    $0x8,%esp
 610:	50                   	push   %eax
 611:	ff 75 08             	push   0x8(%ebp)
 614:	e8 91 fd ff ff       	call   3aa <putc>
 619:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 61c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 623:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 627:	8b 55 0c             	mov    0xc(%ebp),%edx
 62a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 62d:	01 d0                	add    %edx,%eax
 62f:	0f b6 00             	movzbl (%eax),%eax
 632:	84 c0                	test   %al,%al
 634:	0f 85 92 fe ff ff    	jne    4cc <printf+0x2e>
    }
  }
}
 63a:	90                   	nop
 63b:	90                   	nop
 63c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 63f:	c9                   	leave  
 640:	c3                   	ret    

00000641 <__x86.get_pc_thunk.cx>:
 641:	8b 0c 24             	mov    (%esp),%ecx
 644:	c3                   	ret    

00000645 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 645:	55                   	push   %ebp
 646:	89 e5                	mov    %esp,%ebp
 648:	83 ec 10             	sub    $0x10,%esp
 64b:	e8 a6 fc ff ff       	call   2f6 <__x86.get_pc_thunk.ax>
 650:	05 f4 04 00 00       	add    $0x4f4,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
 655:	8b 55 08             	mov    0x8(%ebp),%edx
 658:	83 ea 08             	sub    $0x8,%edx
 65b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 65e:	8b 90 28 00 00 00    	mov    0x28(%eax),%edx
 664:	89 55 fc             	mov    %edx,-0x4(%ebp)
 667:	eb 24                	jmp    68d <free+0x48>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 669:	8b 55 fc             	mov    -0x4(%ebp),%edx
 66c:	8b 12                	mov    (%edx),%edx
 66e:	39 55 fc             	cmp    %edx,-0x4(%ebp)
 671:	72 12                	jb     685 <free+0x40>
 673:	8b 55 f8             	mov    -0x8(%ebp),%edx
 676:	3b 55 fc             	cmp    -0x4(%ebp),%edx
 679:	77 24                	ja     69f <free+0x5a>
 67b:	8b 55 fc             	mov    -0x4(%ebp),%edx
 67e:	8b 12                	mov    (%edx),%edx
 680:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 683:	72 1a                	jb     69f <free+0x5a>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 685:	8b 55 fc             	mov    -0x4(%ebp),%edx
 688:	8b 12                	mov    (%edx),%edx
 68a:	89 55 fc             	mov    %edx,-0x4(%ebp)
 68d:	8b 55 f8             	mov    -0x8(%ebp),%edx
 690:	3b 55 fc             	cmp    -0x4(%ebp),%edx
 693:	76 d4                	jbe    669 <free+0x24>
 695:	8b 55 fc             	mov    -0x4(%ebp),%edx
 698:	8b 12                	mov    (%edx),%edx
 69a:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 69d:	73 ca                	jae    669 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 69f:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6a2:	8b 52 04             	mov    0x4(%edx),%edx
 6a5:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
 6ac:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6af:	01 d1                	add    %edx,%ecx
 6b1:	8b 55 fc             	mov    -0x4(%ebp),%edx
 6b4:	8b 12                	mov    (%edx),%edx
 6b6:	39 d1                	cmp    %edx,%ecx
 6b8:	75 24                	jne    6de <free+0x99>
    bp->s.size += p->s.ptr->s.size;
 6ba:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6bd:	8b 4a 04             	mov    0x4(%edx),%ecx
 6c0:	8b 55 fc             	mov    -0x4(%ebp),%edx
 6c3:	8b 12                	mov    (%edx),%edx
 6c5:	8b 52 04             	mov    0x4(%edx),%edx
 6c8:	01 d1                	add    %edx,%ecx
 6ca:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6cd:	89 4a 04             	mov    %ecx,0x4(%edx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6d0:	8b 55 fc             	mov    -0x4(%ebp),%edx
 6d3:	8b 12                	mov    (%edx),%edx
 6d5:	8b 0a                	mov    (%edx),%ecx
 6d7:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6da:	89 0a                	mov    %ecx,(%edx)
 6dc:	eb 0a                	jmp    6e8 <free+0xa3>
  } else
    bp->s.ptr = p->s.ptr;
 6de:	8b 55 fc             	mov    -0x4(%ebp),%edx
 6e1:	8b 0a                	mov    (%edx),%ecx
 6e3:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6e6:	89 0a                	mov    %ecx,(%edx)
  if(p + p->s.size == bp){
 6e8:	8b 55 fc             	mov    -0x4(%ebp),%edx
 6eb:	8b 52 04             	mov    0x4(%edx),%edx
 6ee:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
 6f5:	8b 55 fc             	mov    -0x4(%ebp),%edx
 6f8:	01 ca                	add    %ecx,%edx
 6fa:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 6fd:	75 20                	jne    71f <free+0xda>
    p->s.size += bp->s.size;
 6ff:	8b 55 fc             	mov    -0x4(%ebp),%edx
 702:	8b 4a 04             	mov    0x4(%edx),%ecx
 705:	8b 55 f8             	mov    -0x8(%ebp),%edx
 708:	8b 52 04             	mov    0x4(%edx),%edx
 70b:	01 d1                	add    %edx,%ecx
 70d:	8b 55 fc             	mov    -0x4(%ebp),%edx
 710:	89 4a 04             	mov    %ecx,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 713:	8b 55 f8             	mov    -0x8(%ebp),%edx
 716:	8b 0a                	mov    (%edx),%ecx
 718:	8b 55 fc             	mov    -0x4(%ebp),%edx
 71b:	89 0a                	mov    %ecx,(%edx)
 71d:	eb 08                	jmp    727 <free+0xe2>
  } else
    p->s.ptr = bp;
 71f:	8b 55 fc             	mov    -0x4(%ebp),%edx
 722:	8b 4d f8             	mov    -0x8(%ebp),%ecx
 725:	89 0a                	mov    %ecx,(%edx)
  freep = p;
 727:	8b 55 fc             	mov    -0x4(%ebp),%edx
 72a:	89 90 28 00 00 00    	mov    %edx,0x28(%eax)
}
 730:	90                   	nop
 731:	c9                   	leave  
 732:	c3                   	ret    

00000733 <morecore>:

static Header*
morecore(uint nu)
{
 733:	55                   	push   %ebp
 734:	89 e5                	mov    %esp,%ebp
 736:	53                   	push   %ebx
 737:	83 ec 14             	sub    $0x14,%esp
 73a:	e8 f6 f8 ff ff       	call   35 <__x86.get_pc_thunk.bx>
 73f:	81 c3 05 04 00 00    	add    $0x405,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 745:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 74c:	77 07                	ja     755 <morecore+0x22>
    nu = 4096;
 74e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 755:	8b 45 08             	mov    0x8(%ebp),%eax
 758:	c1 e0 03             	shl    $0x3,%eax
 75b:	83 ec 0c             	sub    $0xc,%esp
 75e:	50                   	push   %eax
 75f:	e8 26 fc ff ff       	call   38a <sbrk>
 764:	83 c4 10             	add    $0x10,%esp
 767:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 76a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 76e:	75 07                	jne    777 <morecore+0x44>
    return 0;
 770:	b8 00 00 00 00       	mov    $0x0,%eax
 775:	eb 27                	jmp    79e <morecore+0x6b>
  hp = (Header*)p;
 777:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 77d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 780:	8b 55 08             	mov    0x8(%ebp),%edx
 783:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 786:	8b 45 f0             	mov    -0x10(%ebp),%eax
 789:	83 c0 08             	add    $0x8,%eax
 78c:	83 ec 0c             	sub    $0xc,%esp
 78f:	50                   	push   %eax
 790:	e8 b0 fe ff ff       	call   645 <free>
 795:	83 c4 10             	add    $0x10,%esp
  return freep;
 798:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
}
 79e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 7a1:	c9                   	leave  
 7a2:	c3                   	ret    

000007a3 <malloc>:

void*
malloc(uint nbytes)
{
 7a3:	55                   	push   %ebp
 7a4:	89 e5                	mov    %esp,%ebp
 7a6:	53                   	push   %ebx
 7a7:	83 ec 14             	sub    $0x14,%esp
 7aa:	e8 86 f8 ff ff       	call   35 <__x86.get_pc_thunk.bx>
 7af:	81 c3 95 03 00 00    	add    $0x395,%ebx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7b5:	8b 45 08             	mov    0x8(%ebp),%eax
 7b8:	83 c0 07             	add    $0x7,%eax
 7bb:	c1 e8 03             	shr    $0x3,%eax
 7be:	83 c0 01             	add    $0x1,%eax
 7c1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7c4:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
 7ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7cd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7d1:	75 28                	jne    7fb <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
 7d3:	8d 83 20 00 00 00    	lea    0x20(%ebx),%eax
 7d9:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7df:	89 83 28 00 00 00    	mov    %eax,0x28(%ebx)
 7e5:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
 7eb:	89 83 20 00 00 00    	mov    %eax,0x20(%ebx)
    base.s.size = 0;
 7f1:	c7 83 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
 7f8:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7fe:	8b 00                	mov    (%eax),%eax
 800:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 803:	8b 45 f4             	mov    -0xc(%ebp),%eax
 806:	8b 40 04             	mov    0x4(%eax),%eax
 809:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 80c:	77 4e                	ja     85c <malloc+0xb9>
      if(p->s.size == nunits)
 80e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 811:	8b 40 04             	mov    0x4(%eax),%eax
 814:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 817:	75 0c                	jne    825 <malloc+0x82>
        prevp->s.ptr = p->s.ptr;
 819:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81c:	8b 10                	mov    (%eax),%edx
 81e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 821:	89 10                	mov    %edx,(%eax)
 823:	eb 26                	jmp    84b <malloc+0xa8>
      else {
        p->s.size -= nunits;
 825:	8b 45 f4             	mov    -0xc(%ebp),%eax
 828:	8b 40 04             	mov    0x4(%eax),%eax
 82b:	2b 45 ec             	sub    -0x14(%ebp),%eax
 82e:	89 c2                	mov    %eax,%edx
 830:	8b 45 f4             	mov    -0xc(%ebp),%eax
 833:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 836:	8b 45 f4             	mov    -0xc(%ebp),%eax
 839:	8b 40 04             	mov    0x4(%eax),%eax
 83c:	c1 e0 03             	shl    $0x3,%eax
 83f:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 842:	8b 45 f4             	mov    -0xc(%ebp),%eax
 845:	8b 55 ec             	mov    -0x14(%ebp),%edx
 848:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 84b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 84e:	89 83 28 00 00 00    	mov    %eax,0x28(%ebx)
      return (void*)(p + 1);
 854:	8b 45 f4             	mov    -0xc(%ebp),%eax
 857:	83 c0 08             	add    $0x8,%eax
 85a:	eb 3c                	jmp    898 <malloc+0xf5>
    }
    if(p == freep)
 85c:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
 862:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 865:	75 1e                	jne    885 <malloc+0xe2>
      if((p = morecore(nunits)) == 0)
 867:	83 ec 0c             	sub    $0xc,%esp
 86a:	ff 75 ec             	push   -0x14(%ebp)
 86d:	e8 c1 fe ff ff       	call   733 <morecore>
 872:	83 c4 10             	add    $0x10,%esp
 875:	89 45 f4             	mov    %eax,-0xc(%ebp)
 878:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 87c:	75 07                	jne    885 <malloc+0xe2>
        return 0;
 87e:	b8 00 00 00 00       	mov    $0x0,%eax
 883:	eb 13                	jmp    898 <malloc+0xf5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 885:	8b 45 f4             	mov    -0xc(%ebp),%eax
 888:	89 45 f0             	mov    %eax,-0x10(%ebp)
 88b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88e:	8b 00                	mov    (%eax),%eax
 890:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 893:	e9 6b ff ff ff       	jmp    803 <malloc+0x60>
  }
}
 898:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 89b:	c9                   	leave  
 89c:	c3                   	ret    

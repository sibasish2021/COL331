
_grep:     file format elf32-i386


Disassembly of section .text:

00000000 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 ec 14             	sub    $0x14,%esp
   7:	e8 71 03 00 00       	call   37d <__x86.get_pc_thunk.bx>
   c:	81 c3 40 0f 00 00    	add    $0xf40,%ebx
  int n, m;
  char *p, *q;

  m = 0;
  12:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
  19:	e9 ba 00 00 00       	jmp    d8 <grep+0xd8>
    m += n;
  1e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  21:	01 45 f4             	add    %eax,-0xc(%ebp)
    buf[m] = '\0';
  24:	8d 93 34 00 00 00    	lea    0x34(%ebx),%edx
  2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  2d:	01 d0                	add    %edx,%eax
  2f:	c6 00 00             	movb   $0x0,(%eax)
    p = buf;
  32:	8d 83 34 00 00 00    	lea    0x34(%ebx),%eax
  38:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while((q = strchr(p, '\n')) != 0){
  3b:	eb 44                	jmp    81 <grep+0x81>
      *q = 0;
  3d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  40:	c6 00 00             	movb   $0x0,(%eax)
      if(match(pattern, p)){
  43:	83 ec 08             	sub    $0x8,%esp
  46:	ff 75 f0             	push   -0x10(%ebp)
  49:	ff 75 08             	push   0x8(%ebp)
  4c:	e8 ae 01 00 00       	call   1ff <match>
  51:	83 c4 10             	add    $0x10,%esp
  54:	85 c0                	test   %eax,%eax
  56:	74 20                	je     78 <grep+0x78>
        *q = '\n';
  58:	8b 45 e8             	mov    -0x18(%ebp),%eax
  5b:	c6 00 0a             	movb   $0xa,(%eax)
        write(1, p, q+1 - p);
  5e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  61:	83 c0 01             	add    $0x1,%eax
  64:	2b 45 f0             	sub    -0x10(%ebp),%eax
  67:	83 ec 04             	sub    $0x4,%esp
  6a:	50                   	push   %eax
  6b:	ff 75 f0             	push   -0x10(%ebp)
  6e:	6a 01                	push   $0x1
  70:	e8 f1 05 00 00       	call   666 <write>
  75:	83 c4 10             	add    $0x10,%esp
      }
      p = q+1;
  78:	8b 45 e8             	mov    -0x18(%ebp),%eax
  7b:	83 c0 01             	add    $0x1,%eax
  7e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while((q = strchr(p, '\n')) != 0){
  81:	83 ec 08             	sub    $0x8,%esp
  84:	6a 0a                	push   $0xa
  86:	ff 75 f0             	push   -0x10(%ebp)
  89:	e8 fb 03 00 00       	call   489 <strchr>
  8e:	83 c4 10             	add    $0x10,%esp
  91:	89 45 e8             	mov    %eax,-0x18(%ebp)
  94:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  98:	75 a3                	jne    3d <grep+0x3d>
    }
    if(p == buf)
  9a:	8d 83 34 00 00 00    	lea    0x34(%ebx),%eax
  a0:	39 45 f0             	cmp    %eax,-0x10(%ebp)
  a3:	75 07                	jne    ac <grep+0xac>
      m = 0;
  a5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(m > 0){
  ac:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  b0:	7e 26                	jle    d8 <grep+0xd8>
      m -= p - buf;
  b2:	8d 93 34 00 00 00    	lea    0x34(%ebx),%edx
  b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  bb:	29 d0                	sub    %edx,%eax
  bd:	29 45 f4             	sub    %eax,-0xc(%ebp)
      memmove(buf, p, m);
  c0:	83 ec 04             	sub    $0x4,%esp
  c3:	ff 75 f4             	push   -0xc(%ebp)
  c6:	ff 75 f0             	push   -0x10(%ebp)
  c9:	8d 83 34 00 00 00    	lea    0x34(%ebx),%eax
  cf:	50                   	push   %eax
  d0:	e8 22 05 00 00       	call   5f7 <memmove>
  d5:	83 c4 10             	add    $0x10,%esp
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
  d8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  db:	b8 ff 03 00 00       	mov    $0x3ff,%eax
  e0:	29 d0                	sub    %edx,%eax
  e2:	89 c2                	mov    %eax,%edx
  e4:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  e7:	8d 83 34 00 00 00    	lea    0x34(%ebx),%eax
  ed:	01 c8                	add    %ecx,%eax
  ef:	83 ec 04             	sub    $0x4,%esp
  f2:	52                   	push   %edx
  f3:	50                   	push   %eax
  f4:	ff 75 0c             	push   0xc(%ebp)
  f7:	e8 62 05 00 00       	call   65e <read>
  fc:	83 c4 10             	add    $0x10,%esp
  ff:	89 45 ec             	mov    %eax,-0x14(%ebp)
 102:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 106:	0f 8f 12 ff ff ff    	jg     1e <grep+0x1e>
    }
  }
}
 10c:	90                   	nop
 10d:	90                   	nop
 10e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 111:	c9                   	leave  
 112:	c3                   	ret    

00000113 <main>:

int
main(int argc, char *argv[])
{
 113:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 117:	83 e4 f0             	and    $0xfffffff0,%esp
 11a:	ff 71 fc             	push   -0x4(%ecx)
 11d:	55                   	push   %ebp
 11e:	89 e5                	mov    %esp,%ebp
 120:	56                   	push   %esi
 121:	53                   	push   %ebx
 122:	51                   	push   %ecx
 123:	83 ec 1c             	sub    $0x1c,%esp
 126:	e8 52 02 00 00       	call   37d <__x86.get_pc_thunk.bx>
 12b:	81 c3 21 0e 00 00    	add    $0xe21,%ebx
 131:	89 ce                	mov    %ecx,%esi
  int fd, i;
  char *pattern;

  if(argc <= 1){
 133:	83 3e 01             	cmpl   $0x1,(%esi)
 136:	7f 19                	jg     151 <main+0x3e>
    printf(2, "usage: grep pattern [file ...]\n");
 138:	83 ec 08             	sub    $0x8,%esp
 13b:	8d 83 98 fc ff ff    	lea    -0x368(%ebx),%eax
 141:	50                   	push   %eax
 142:	6a 02                	push   $0x2
 144:	e8 99 06 00 00       	call   7e2 <printf>
 149:	83 c4 10             	add    $0x10,%esp
    exit();
 14c:	e8 f5 04 00 00       	call   646 <exit>
  }
  pattern = argv[1];
 151:	8b 46 04             	mov    0x4(%esi),%eax
 154:	8b 40 04             	mov    0x4(%eax),%eax
 157:	89 45 e0             	mov    %eax,-0x20(%ebp)

  if(argc <= 2){
 15a:	83 3e 02             	cmpl   $0x2,(%esi)
 15d:	7f 15                	jg     174 <main+0x61>
    grep(pattern, 0);
 15f:	83 ec 08             	sub    $0x8,%esp
 162:	6a 00                	push   $0x0
 164:	ff 75 e0             	push   -0x20(%ebp)
 167:	e8 94 fe ff ff       	call   0 <grep>
 16c:	83 c4 10             	add    $0x10,%esp
    exit();
 16f:	e8 d2 04 00 00       	call   646 <exit>
  }

  for(i = 2; i < argc; i++){
 174:	c7 45 e4 02 00 00 00 	movl   $0x2,-0x1c(%ebp)
 17b:	eb 76                	jmp    1f3 <main+0xe0>
    if((fd = open(argv[i], 0)) < 0){
 17d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 180:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 187:	8b 46 04             	mov    0x4(%esi),%eax
 18a:	01 d0                	add    %edx,%eax
 18c:	8b 00                	mov    (%eax),%eax
 18e:	83 ec 08             	sub    $0x8,%esp
 191:	6a 00                	push   $0x0
 193:	50                   	push   %eax
 194:	e8 ed 04 00 00       	call   686 <open>
 199:	83 c4 10             	add    $0x10,%esp
 19c:	89 45 dc             	mov    %eax,-0x24(%ebp)
 19f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
 1a3:	79 2b                	jns    1d0 <main+0xbd>
      printf(1, "grep: cannot open %s\n", argv[i]);
 1a5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 1a8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 1af:	8b 46 04             	mov    0x4(%esi),%eax
 1b2:	01 d0                	add    %edx,%eax
 1b4:	8b 00                	mov    (%eax),%eax
 1b6:	83 ec 04             	sub    $0x4,%esp
 1b9:	50                   	push   %eax
 1ba:	8d 83 b8 fc ff ff    	lea    -0x348(%ebx),%eax
 1c0:	50                   	push   %eax
 1c1:	6a 01                	push   $0x1
 1c3:	e8 1a 06 00 00       	call   7e2 <printf>
 1c8:	83 c4 10             	add    $0x10,%esp
      exit();
 1cb:	e8 76 04 00 00       	call   646 <exit>
    }
    grep(pattern, fd);
 1d0:	83 ec 08             	sub    $0x8,%esp
 1d3:	ff 75 dc             	push   -0x24(%ebp)
 1d6:	ff 75 e0             	push   -0x20(%ebp)
 1d9:	e8 22 fe ff ff       	call   0 <grep>
 1de:	83 c4 10             	add    $0x10,%esp
    close(fd);
 1e1:	83 ec 0c             	sub    $0xc,%esp
 1e4:	ff 75 dc             	push   -0x24(%ebp)
 1e7:	e8 82 04 00 00       	call   66e <close>
 1ec:	83 c4 10             	add    $0x10,%esp
  for(i = 2; i < argc; i++){
 1ef:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
 1f3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 1f6:	3b 06                	cmp    (%esi),%eax
 1f8:	7c 83                	jl     17d <main+0x6a>
  }
  exit();
 1fa:	e8 47 04 00 00       	call   646 <exit>

000001ff <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
 1ff:	55                   	push   %ebp
 200:	89 e5                	mov    %esp,%ebp
 202:	83 ec 08             	sub    $0x8,%esp
 205:	e8 6f 01 00 00       	call   379 <__x86.get_pc_thunk.ax>
 20a:	05 42 0d 00 00       	add    $0xd42,%eax
  if(re[0] == '^')
 20f:	8b 45 08             	mov    0x8(%ebp),%eax
 212:	0f b6 00             	movzbl (%eax),%eax
 215:	3c 5e                	cmp    $0x5e,%al
 217:	75 17                	jne    230 <match+0x31>
    return matchhere(re+1, text);
 219:	8b 45 08             	mov    0x8(%ebp),%eax
 21c:	83 c0 01             	add    $0x1,%eax
 21f:	83 ec 08             	sub    $0x8,%esp
 222:	ff 75 0c             	push   0xc(%ebp)
 225:	50                   	push   %eax
 226:	e8 38 00 00 00       	call   263 <matchhere>
 22b:	83 c4 10             	add    $0x10,%esp
 22e:	eb 31                	jmp    261 <match+0x62>
  do{  // must look at empty string
    if(matchhere(re, text))
 230:	83 ec 08             	sub    $0x8,%esp
 233:	ff 75 0c             	push   0xc(%ebp)
 236:	ff 75 08             	push   0x8(%ebp)
 239:	e8 25 00 00 00       	call   263 <matchhere>
 23e:	83 c4 10             	add    $0x10,%esp
 241:	85 c0                	test   %eax,%eax
 243:	74 07                	je     24c <match+0x4d>
      return 1;
 245:	b8 01 00 00 00       	mov    $0x1,%eax
 24a:	eb 15                	jmp    261 <match+0x62>
  }while(*text++ != '\0');
 24c:	8b 45 0c             	mov    0xc(%ebp),%eax
 24f:	8d 50 01             	lea    0x1(%eax),%edx
 252:	89 55 0c             	mov    %edx,0xc(%ebp)
 255:	0f b6 00             	movzbl (%eax),%eax
 258:	84 c0                	test   %al,%al
 25a:	75 d4                	jne    230 <match+0x31>
  return 0;
 25c:	b8 00 00 00 00       	mov    $0x0,%eax
}
 261:	c9                   	leave  
 262:	c3                   	ret    

00000263 <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
 263:	55                   	push   %ebp
 264:	89 e5                	mov    %esp,%ebp
 266:	83 ec 08             	sub    $0x8,%esp
 269:	e8 0b 01 00 00       	call   379 <__x86.get_pc_thunk.ax>
 26e:	05 de 0c 00 00       	add    $0xcde,%eax
  if(re[0] == '\0')
 273:	8b 45 08             	mov    0x8(%ebp),%eax
 276:	0f b6 00             	movzbl (%eax),%eax
 279:	84 c0                	test   %al,%al
 27b:	75 0a                	jne    287 <matchhere+0x24>
    return 1;
 27d:	b8 01 00 00 00       	mov    $0x1,%eax
 282:	e9 99 00 00 00       	jmp    320 <matchhere+0xbd>
  if(re[1] == '*')
 287:	8b 45 08             	mov    0x8(%ebp),%eax
 28a:	83 c0 01             	add    $0x1,%eax
 28d:	0f b6 00             	movzbl (%eax),%eax
 290:	3c 2a                	cmp    $0x2a,%al
 292:	75 21                	jne    2b5 <matchhere+0x52>
    return matchstar(re[0], re+2, text);
 294:	8b 45 08             	mov    0x8(%ebp),%eax
 297:	8d 50 02             	lea    0x2(%eax),%edx
 29a:	8b 45 08             	mov    0x8(%ebp),%eax
 29d:	0f b6 00             	movzbl (%eax),%eax
 2a0:	0f be c0             	movsbl %al,%eax
 2a3:	83 ec 04             	sub    $0x4,%esp
 2a6:	ff 75 0c             	push   0xc(%ebp)
 2a9:	52                   	push   %edx
 2aa:	50                   	push   %eax
 2ab:	e8 72 00 00 00       	call   322 <matchstar>
 2b0:	83 c4 10             	add    $0x10,%esp
 2b3:	eb 6b                	jmp    320 <matchhere+0xbd>
  if(re[0] == '$' && re[1] == '\0')
 2b5:	8b 45 08             	mov    0x8(%ebp),%eax
 2b8:	0f b6 00             	movzbl (%eax),%eax
 2bb:	3c 24                	cmp    $0x24,%al
 2bd:	75 1d                	jne    2dc <matchhere+0x79>
 2bf:	8b 45 08             	mov    0x8(%ebp),%eax
 2c2:	83 c0 01             	add    $0x1,%eax
 2c5:	0f b6 00             	movzbl (%eax),%eax
 2c8:	84 c0                	test   %al,%al
 2ca:	75 10                	jne    2dc <matchhere+0x79>
    return *text == '\0';
 2cc:	8b 45 0c             	mov    0xc(%ebp),%eax
 2cf:	0f b6 00             	movzbl (%eax),%eax
 2d2:	84 c0                	test   %al,%al
 2d4:	0f 94 c0             	sete   %al
 2d7:	0f b6 c0             	movzbl %al,%eax
 2da:	eb 44                	jmp    320 <matchhere+0xbd>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 2dc:	8b 45 0c             	mov    0xc(%ebp),%eax
 2df:	0f b6 00             	movzbl (%eax),%eax
 2e2:	84 c0                	test   %al,%al
 2e4:	74 35                	je     31b <matchhere+0xb8>
 2e6:	8b 45 08             	mov    0x8(%ebp),%eax
 2e9:	0f b6 00             	movzbl (%eax),%eax
 2ec:	3c 2e                	cmp    $0x2e,%al
 2ee:	74 10                	je     300 <matchhere+0x9d>
 2f0:	8b 45 08             	mov    0x8(%ebp),%eax
 2f3:	0f b6 10             	movzbl (%eax),%edx
 2f6:	8b 45 0c             	mov    0xc(%ebp),%eax
 2f9:	0f b6 00             	movzbl (%eax),%eax
 2fc:	38 c2                	cmp    %al,%dl
 2fe:	75 1b                	jne    31b <matchhere+0xb8>
    return matchhere(re+1, text+1);
 300:	8b 45 0c             	mov    0xc(%ebp),%eax
 303:	8d 50 01             	lea    0x1(%eax),%edx
 306:	8b 45 08             	mov    0x8(%ebp),%eax
 309:	83 c0 01             	add    $0x1,%eax
 30c:	83 ec 08             	sub    $0x8,%esp
 30f:	52                   	push   %edx
 310:	50                   	push   %eax
 311:	e8 4d ff ff ff       	call   263 <matchhere>
 316:	83 c4 10             	add    $0x10,%esp
 319:	eb 05                	jmp    320 <matchhere+0xbd>
  return 0;
 31b:	b8 00 00 00 00       	mov    $0x0,%eax
}
 320:	c9                   	leave  
 321:	c3                   	ret    

00000322 <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
 322:	55                   	push   %ebp
 323:	89 e5                	mov    %esp,%ebp
 325:	83 ec 08             	sub    $0x8,%esp
 328:	e8 4c 00 00 00       	call   379 <__x86.get_pc_thunk.ax>
 32d:	05 1f 0c 00 00       	add    $0xc1f,%eax
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
 332:	83 ec 08             	sub    $0x8,%esp
 335:	ff 75 10             	push   0x10(%ebp)
 338:	ff 75 0c             	push   0xc(%ebp)
 33b:	e8 23 ff ff ff       	call   263 <matchhere>
 340:	83 c4 10             	add    $0x10,%esp
 343:	85 c0                	test   %eax,%eax
 345:	74 07                	je     34e <matchstar+0x2c>
      return 1;
 347:	b8 01 00 00 00       	mov    $0x1,%eax
 34c:	eb 29                	jmp    377 <matchstar+0x55>
  }while(*text!='\0' && (*text++==c || c=='.'));
 34e:	8b 45 10             	mov    0x10(%ebp),%eax
 351:	0f b6 00             	movzbl (%eax),%eax
 354:	84 c0                	test   %al,%al
 356:	74 1a                	je     372 <matchstar+0x50>
 358:	8b 45 10             	mov    0x10(%ebp),%eax
 35b:	8d 50 01             	lea    0x1(%eax),%edx
 35e:	89 55 10             	mov    %edx,0x10(%ebp)
 361:	0f b6 00             	movzbl (%eax),%eax
 364:	0f be c0             	movsbl %al,%eax
 367:	39 45 08             	cmp    %eax,0x8(%ebp)
 36a:	74 c6                	je     332 <matchstar+0x10>
 36c:	83 7d 08 2e          	cmpl   $0x2e,0x8(%ebp)
 370:	74 c0                	je     332 <matchstar+0x10>
  return 0;
 372:	b8 00 00 00 00       	mov    $0x0,%eax
}
 377:	c9                   	leave  
 378:	c3                   	ret    

00000379 <__x86.get_pc_thunk.ax>:
 379:	8b 04 24             	mov    (%esp),%eax
 37c:	c3                   	ret    

0000037d <__x86.get_pc_thunk.bx>:
 37d:	8b 1c 24             	mov    (%esp),%ebx
 380:	c3                   	ret    

00000381 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 381:	55                   	push   %ebp
 382:	89 e5                	mov    %esp,%ebp
 384:	57                   	push   %edi
 385:	53                   	push   %ebx
 386:	e8 ee ff ff ff       	call   379 <__x86.get_pc_thunk.ax>
 38b:	05 c1 0b 00 00       	add    $0xbc1,%eax
  asm volatile("cld; rep stosb" :
 390:	8b 4d 08             	mov    0x8(%ebp),%ecx
 393:	8b 55 10             	mov    0x10(%ebp),%edx
 396:	8b 45 0c             	mov    0xc(%ebp),%eax
 399:	89 cb                	mov    %ecx,%ebx
 39b:	89 df                	mov    %ebx,%edi
 39d:	89 d1                	mov    %edx,%ecx
 39f:	fc                   	cld    
 3a0:	f3 aa                	rep stos %al,%es:(%edi)
 3a2:	89 ca                	mov    %ecx,%edx
 3a4:	89 fb                	mov    %edi,%ebx
 3a6:	89 5d 08             	mov    %ebx,0x8(%ebp)
 3a9:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 3ac:	90                   	nop
 3ad:	5b                   	pop    %ebx
 3ae:	5f                   	pop    %edi
 3af:	5d                   	pop    %ebp
 3b0:	c3                   	ret    

000003b1 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 3b1:	55                   	push   %ebp
 3b2:	89 e5                	mov    %esp,%ebp
 3b4:	83 ec 10             	sub    $0x10,%esp
 3b7:	e8 bd ff ff ff       	call   379 <__x86.get_pc_thunk.ax>
 3bc:	05 90 0b 00 00       	add    $0xb90,%eax
  char *os;

  os = s;
 3c1:	8b 45 08             	mov    0x8(%ebp),%eax
 3c4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 3c7:	90                   	nop
 3c8:	8b 55 0c             	mov    0xc(%ebp),%edx
 3cb:	8d 42 01             	lea    0x1(%edx),%eax
 3ce:	89 45 0c             	mov    %eax,0xc(%ebp)
 3d1:	8b 45 08             	mov    0x8(%ebp),%eax
 3d4:	8d 48 01             	lea    0x1(%eax),%ecx
 3d7:	89 4d 08             	mov    %ecx,0x8(%ebp)
 3da:	0f b6 12             	movzbl (%edx),%edx
 3dd:	88 10                	mov    %dl,(%eax)
 3df:	0f b6 00             	movzbl (%eax),%eax
 3e2:	84 c0                	test   %al,%al
 3e4:	75 e2                	jne    3c8 <strcpy+0x17>
    ;
  return os;
 3e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3e9:	c9                   	leave  
 3ea:	c3                   	ret    

000003eb <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3eb:	55                   	push   %ebp
 3ec:	89 e5                	mov    %esp,%ebp
 3ee:	e8 86 ff ff ff       	call   379 <__x86.get_pc_thunk.ax>
 3f3:	05 59 0b 00 00       	add    $0xb59,%eax
  while(*p && *p == *q)
 3f8:	eb 08                	jmp    402 <strcmp+0x17>
    p++, q++;
 3fa:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 3fe:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 402:	8b 45 08             	mov    0x8(%ebp),%eax
 405:	0f b6 00             	movzbl (%eax),%eax
 408:	84 c0                	test   %al,%al
 40a:	74 10                	je     41c <strcmp+0x31>
 40c:	8b 45 08             	mov    0x8(%ebp),%eax
 40f:	0f b6 10             	movzbl (%eax),%edx
 412:	8b 45 0c             	mov    0xc(%ebp),%eax
 415:	0f b6 00             	movzbl (%eax),%eax
 418:	38 c2                	cmp    %al,%dl
 41a:	74 de                	je     3fa <strcmp+0xf>
  return (uchar)*p - (uchar)*q;
 41c:	8b 45 08             	mov    0x8(%ebp),%eax
 41f:	0f b6 00             	movzbl (%eax),%eax
 422:	0f b6 d0             	movzbl %al,%edx
 425:	8b 45 0c             	mov    0xc(%ebp),%eax
 428:	0f b6 00             	movzbl (%eax),%eax
 42b:	0f b6 c8             	movzbl %al,%ecx
 42e:	89 d0                	mov    %edx,%eax
 430:	29 c8                	sub    %ecx,%eax
}
 432:	5d                   	pop    %ebp
 433:	c3                   	ret    

00000434 <strlen>:

uint
strlen(const char *s)
{
 434:	55                   	push   %ebp
 435:	89 e5                	mov    %esp,%ebp
 437:	83 ec 10             	sub    $0x10,%esp
 43a:	e8 3a ff ff ff       	call   379 <__x86.get_pc_thunk.ax>
 43f:	05 0d 0b 00 00       	add    $0xb0d,%eax
  int n;

  for(n = 0; s[n]; n++)
 444:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 44b:	eb 04                	jmp    451 <strlen+0x1d>
 44d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 451:	8b 55 fc             	mov    -0x4(%ebp),%edx
 454:	8b 45 08             	mov    0x8(%ebp),%eax
 457:	01 d0                	add    %edx,%eax
 459:	0f b6 00             	movzbl (%eax),%eax
 45c:	84 c0                	test   %al,%al
 45e:	75 ed                	jne    44d <strlen+0x19>
    ;
  return n;
 460:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 463:	c9                   	leave  
 464:	c3                   	ret    

00000465 <memset>:

void*
memset(void *dst, int c, uint n)
{
 465:	55                   	push   %ebp
 466:	89 e5                	mov    %esp,%ebp
 468:	e8 0c ff ff ff       	call   379 <__x86.get_pc_thunk.ax>
 46d:	05 df 0a 00 00       	add    $0xadf,%eax
  stosb(dst, c, n);
 472:	8b 45 10             	mov    0x10(%ebp),%eax
 475:	50                   	push   %eax
 476:	ff 75 0c             	push   0xc(%ebp)
 479:	ff 75 08             	push   0x8(%ebp)
 47c:	e8 00 ff ff ff       	call   381 <stosb>
 481:	83 c4 0c             	add    $0xc,%esp
  return dst;
 484:	8b 45 08             	mov    0x8(%ebp),%eax
}
 487:	c9                   	leave  
 488:	c3                   	ret    

00000489 <strchr>:

char*
strchr(const char *s, char c)
{
 489:	55                   	push   %ebp
 48a:	89 e5                	mov    %esp,%ebp
 48c:	83 ec 04             	sub    $0x4,%esp
 48f:	e8 e5 fe ff ff       	call   379 <__x86.get_pc_thunk.ax>
 494:	05 b8 0a 00 00       	add    $0xab8,%eax
 499:	8b 45 0c             	mov    0xc(%ebp),%eax
 49c:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 49f:	eb 14                	jmp    4b5 <strchr+0x2c>
    if(*s == c)
 4a1:	8b 45 08             	mov    0x8(%ebp),%eax
 4a4:	0f b6 00             	movzbl (%eax),%eax
 4a7:	38 45 fc             	cmp    %al,-0x4(%ebp)
 4aa:	75 05                	jne    4b1 <strchr+0x28>
      return (char*)s;
 4ac:	8b 45 08             	mov    0x8(%ebp),%eax
 4af:	eb 13                	jmp    4c4 <strchr+0x3b>
  for(; *s; s++)
 4b1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 4b5:	8b 45 08             	mov    0x8(%ebp),%eax
 4b8:	0f b6 00             	movzbl (%eax),%eax
 4bb:	84 c0                	test   %al,%al
 4bd:	75 e2                	jne    4a1 <strchr+0x18>
  return 0;
 4bf:	b8 00 00 00 00       	mov    $0x0,%eax
}
 4c4:	c9                   	leave  
 4c5:	c3                   	ret    

000004c6 <gets>:

char*
gets(char *buf, int max)
{
 4c6:	55                   	push   %ebp
 4c7:	89 e5                	mov    %esp,%ebp
 4c9:	53                   	push   %ebx
 4ca:	83 ec 14             	sub    $0x14,%esp
 4cd:	e8 ab fe ff ff       	call   37d <__x86.get_pc_thunk.bx>
 4d2:	81 c3 7a 0a 00 00    	add    $0xa7a,%ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4d8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 4df:	eb 42                	jmp    523 <gets+0x5d>
    cc = read(0, &c, 1);
 4e1:	83 ec 04             	sub    $0x4,%esp
 4e4:	6a 01                	push   $0x1
 4e6:	8d 45 ef             	lea    -0x11(%ebp),%eax
 4e9:	50                   	push   %eax
 4ea:	6a 00                	push   $0x0
 4ec:	e8 6d 01 00 00       	call   65e <read>
 4f1:	83 c4 10             	add    $0x10,%esp
 4f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 4f7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4fb:	7e 33                	jle    530 <gets+0x6a>
      break;
    buf[i++] = c;
 4fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 500:	8d 50 01             	lea    0x1(%eax),%edx
 503:	89 55 f4             	mov    %edx,-0xc(%ebp)
 506:	89 c2                	mov    %eax,%edx
 508:	8b 45 08             	mov    0x8(%ebp),%eax
 50b:	01 c2                	add    %eax,%edx
 50d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 511:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 513:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 517:	3c 0a                	cmp    $0xa,%al
 519:	74 16                	je     531 <gets+0x6b>
 51b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 51f:	3c 0d                	cmp    $0xd,%al
 521:	74 0e                	je     531 <gets+0x6b>
  for(i=0; i+1 < max; ){
 523:	8b 45 f4             	mov    -0xc(%ebp),%eax
 526:	83 c0 01             	add    $0x1,%eax
 529:	39 45 0c             	cmp    %eax,0xc(%ebp)
 52c:	7f b3                	jg     4e1 <gets+0x1b>
 52e:	eb 01                	jmp    531 <gets+0x6b>
      break;
 530:	90                   	nop
      break;
  }
  buf[i] = '\0';
 531:	8b 55 f4             	mov    -0xc(%ebp),%edx
 534:	8b 45 08             	mov    0x8(%ebp),%eax
 537:	01 d0                	add    %edx,%eax
 539:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 53c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 53f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 542:	c9                   	leave  
 543:	c3                   	ret    

00000544 <stat>:

int
stat(const char *n, struct stat *st)
{
 544:	55                   	push   %ebp
 545:	89 e5                	mov    %esp,%ebp
 547:	53                   	push   %ebx
 548:	83 ec 14             	sub    $0x14,%esp
 54b:	e8 2d fe ff ff       	call   37d <__x86.get_pc_thunk.bx>
 550:	81 c3 fc 09 00 00    	add    $0x9fc,%ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 556:	83 ec 08             	sub    $0x8,%esp
 559:	6a 00                	push   $0x0
 55b:	ff 75 08             	push   0x8(%ebp)
 55e:	e8 23 01 00 00       	call   686 <open>
 563:	83 c4 10             	add    $0x10,%esp
 566:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 569:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 56d:	79 07                	jns    576 <stat+0x32>
    return -1;
 56f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 574:	eb 25                	jmp    59b <stat+0x57>
  r = fstat(fd, st);
 576:	83 ec 08             	sub    $0x8,%esp
 579:	ff 75 0c             	push   0xc(%ebp)
 57c:	ff 75 f4             	push   -0xc(%ebp)
 57f:	e8 1a 01 00 00       	call   69e <fstat>
 584:	83 c4 10             	add    $0x10,%esp
 587:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 58a:	83 ec 0c             	sub    $0xc,%esp
 58d:	ff 75 f4             	push   -0xc(%ebp)
 590:	e8 d9 00 00 00       	call   66e <close>
 595:	83 c4 10             	add    $0x10,%esp
  return r;
 598:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 59b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 59e:	c9                   	leave  
 59f:	c3                   	ret    

000005a0 <atoi>:

int
atoi(const char *s)
{
 5a0:	55                   	push   %ebp
 5a1:	89 e5                	mov    %esp,%ebp
 5a3:	83 ec 10             	sub    $0x10,%esp
 5a6:	e8 ce fd ff ff       	call   379 <__x86.get_pc_thunk.ax>
 5ab:	05 a1 09 00 00       	add    $0x9a1,%eax
  int n;

  n = 0;
 5b0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 5b7:	eb 25                	jmp    5de <atoi+0x3e>
    n = n*10 + *s++ - '0';
 5b9:	8b 55 fc             	mov    -0x4(%ebp),%edx
 5bc:	89 d0                	mov    %edx,%eax
 5be:	c1 e0 02             	shl    $0x2,%eax
 5c1:	01 d0                	add    %edx,%eax
 5c3:	01 c0                	add    %eax,%eax
 5c5:	89 c1                	mov    %eax,%ecx
 5c7:	8b 45 08             	mov    0x8(%ebp),%eax
 5ca:	8d 50 01             	lea    0x1(%eax),%edx
 5cd:	89 55 08             	mov    %edx,0x8(%ebp)
 5d0:	0f b6 00             	movzbl (%eax),%eax
 5d3:	0f be c0             	movsbl %al,%eax
 5d6:	01 c8                	add    %ecx,%eax
 5d8:	83 e8 30             	sub    $0x30,%eax
 5db:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 5de:	8b 45 08             	mov    0x8(%ebp),%eax
 5e1:	0f b6 00             	movzbl (%eax),%eax
 5e4:	3c 2f                	cmp    $0x2f,%al
 5e6:	7e 0a                	jle    5f2 <atoi+0x52>
 5e8:	8b 45 08             	mov    0x8(%ebp),%eax
 5eb:	0f b6 00             	movzbl (%eax),%eax
 5ee:	3c 39                	cmp    $0x39,%al
 5f0:	7e c7                	jle    5b9 <atoi+0x19>
  return n;
 5f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 5f5:	c9                   	leave  
 5f6:	c3                   	ret    

000005f7 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 5f7:	55                   	push   %ebp
 5f8:	89 e5                	mov    %esp,%ebp
 5fa:	83 ec 10             	sub    $0x10,%esp
 5fd:	e8 77 fd ff ff       	call   379 <__x86.get_pc_thunk.ax>
 602:	05 4a 09 00 00       	add    $0x94a,%eax
  char *dst;
  const char *src;

  dst = vdst;
 607:	8b 45 08             	mov    0x8(%ebp),%eax
 60a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 60d:	8b 45 0c             	mov    0xc(%ebp),%eax
 610:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 613:	eb 17                	jmp    62c <memmove+0x35>
    *dst++ = *src++;
 615:	8b 55 f8             	mov    -0x8(%ebp),%edx
 618:	8d 42 01             	lea    0x1(%edx),%eax
 61b:	89 45 f8             	mov    %eax,-0x8(%ebp)
 61e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 621:	8d 48 01             	lea    0x1(%eax),%ecx
 624:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 627:	0f b6 12             	movzbl (%edx),%edx
 62a:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 62c:	8b 45 10             	mov    0x10(%ebp),%eax
 62f:	8d 50 ff             	lea    -0x1(%eax),%edx
 632:	89 55 10             	mov    %edx,0x10(%ebp)
 635:	85 c0                	test   %eax,%eax
 637:	7f dc                	jg     615 <memmove+0x1e>
  return vdst;
 639:	8b 45 08             	mov    0x8(%ebp),%eax
}
 63c:	c9                   	leave  
 63d:	c3                   	ret    

0000063e <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 63e:	b8 01 00 00 00       	mov    $0x1,%eax
 643:	cd 40                	int    $0x40
 645:	c3                   	ret    

00000646 <exit>:
SYSCALL(exit)
 646:	b8 02 00 00 00       	mov    $0x2,%eax
 64b:	cd 40                	int    $0x40
 64d:	c3                   	ret    

0000064e <wait>:
SYSCALL(wait)
 64e:	b8 03 00 00 00       	mov    $0x3,%eax
 653:	cd 40                	int    $0x40
 655:	c3                   	ret    

00000656 <pipe>:
SYSCALL(pipe)
 656:	b8 04 00 00 00       	mov    $0x4,%eax
 65b:	cd 40                	int    $0x40
 65d:	c3                   	ret    

0000065e <read>:
SYSCALL(read)
 65e:	b8 05 00 00 00       	mov    $0x5,%eax
 663:	cd 40                	int    $0x40
 665:	c3                   	ret    

00000666 <write>:
SYSCALL(write)
 666:	b8 10 00 00 00       	mov    $0x10,%eax
 66b:	cd 40                	int    $0x40
 66d:	c3                   	ret    

0000066e <close>:
SYSCALL(close)
 66e:	b8 15 00 00 00       	mov    $0x15,%eax
 673:	cd 40                	int    $0x40
 675:	c3                   	ret    

00000676 <kill>:
SYSCALL(kill)
 676:	b8 06 00 00 00       	mov    $0x6,%eax
 67b:	cd 40                	int    $0x40
 67d:	c3                   	ret    

0000067e <exec>:
SYSCALL(exec)
 67e:	b8 07 00 00 00       	mov    $0x7,%eax
 683:	cd 40                	int    $0x40
 685:	c3                   	ret    

00000686 <open>:
SYSCALL(open)
 686:	b8 0f 00 00 00       	mov    $0xf,%eax
 68b:	cd 40                	int    $0x40
 68d:	c3                   	ret    

0000068e <mknod>:
SYSCALL(mknod)
 68e:	b8 11 00 00 00       	mov    $0x11,%eax
 693:	cd 40                	int    $0x40
 695:	c3                   	ret    

00000696 <unlink>:
SYSCALL(unlink)
 696:	b8 12 00 00 00       	mov    $0x12,%eax
 69b:	cd 40                	int    $0x40
 69d:	c3                   	ret    

0000069e <fstat>:
SYSCALL(fstat)
 69e:	b8 08 00 00 00       	mov    $0x8,%eax
 6a3:	cd 40                	int    $0x40
 6a5:	c3                   	ret    

000006a6 <link>:
SYSCALL(link)
 6a6:	b8 13 00 00 00       	mov    $0x13,%eax
 6ab:	cd 40                	int    $0x40
 6ad:	c3                   	ret    

000006ae <mkdir>:
SYSCALL(mkdir)
 6ae:	b8 14 00 00 00       	mov    $0x14,%eax
 6b3:	cd 40                	int    $0x40
 6b5:	c3                   	ret    

000006b6 <chdir>:
SYSCALL(chdir)
 6b6:	b8 09 00 00 00       	mov    $0x9,%eax
 6bb:	cd 40                	int    $0x40
 6bd:	c3                   	ret    

000006be <dup>:
SYSCALL(dup)
 6be:	b8 0a 00 00 00       	mov    $0xa,%eax
 6c3:	cd 40                	int    $0x40
 6c5:	c3                   	ret    

000006c6 <getpid>:
SYSCALL(getpid)
 6c6:	b8 0b 00 00 00       	mov    $0xb,%eax
 6cb:	cd 40                	int    $0x40
 6cd:	c3                   	ret    

000006ce <sbrk>:
SYSCALL(sbrk)
 6ce:	b8 0c 00 00 00       	mov    $0xc,%eax
 6d3:	cd 40                	int    $0x40
 6d5:	c3                   	ret    

000006d6 <sleep>:
SYSCALL(sleep)
 6d6:	b8 0d 00 00 00       	mov    $0xd,%eax
 6db:	cd 40                	int    $0x40
 6dd:	c3                   	ret    

000006de <uptime>:
SYSCALL(uptime)
 6de:	b8 0e 00 00 00       	mov    $0xe,%eax
 6e3:	cd 40                	int    $0x40
 6e5:	c3                   	ret    

000006e6 <random>:
SYSCALL(random)
 6e6:	b8 16 00 00 00       	mov    $0x16,%eax
 6eb:	cd 40                	int    $0x40
 6ed:	c3                   	ret    

000006ee <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 6ee:	55                   	push   %ebp
 6ef:	89 e5                	mov    %esp,%ebp
 6f1:	53                   	push   %ebx
 6f2:	83 ec 14             	sub    $0x14,%esp
 6f5:	e8 7f fc ff ff       	call   379 <__x86.get_pc_thunk.ax>
 6fa:	05 52 08 00 00       	add    $0x852,%eax
 6ff:	8b 55 0c             	mov    0xc(%ebp),%edx
 702:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 705:	83 ec 04             	sub    $0x4,%esp
 708:	6a 01                	push   $0x1
 70a:	8d 55 f4             	lea    -0xc(%ebp),%edx
 70d:	52                   	push   %edx
 70e:	ff 75 08             	push   0x8(%ebp)
 711:	89 c3                	mov    %eax,%ebx
 713:	e8 4e ff ff ff       	call   666 <write>
 718:	83 c4 10             	add    $0x10,%esp
}
 71b:	90                   	nop
 71c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 71f:	c9                   	leave  
 720:	c3                   	ret    

00000721 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 721:	55                   	push   %ebp
 722:	89 e5                	mov    %esp,%ebp
 724:	53                   	push   %ebx
 725:	83 ec 24             	sub    $0x24,%esp
 728:	e8 58 02 00 00       	call   985 <__x86.get_pc_thunk.cx>
 72d:	81 c1 1f 08 00 00    	add    $0x81f,%ecx
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 733:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 73a:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 73e:	74 17                	je     757 <printint+0x36>
 740:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 744:	79 11                	jns    757 <printint+0x36>
    neg = 1;
 746:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 74d:	8b 45 0c             	mov    0xc(%ebp),%eax
 750:	f7 d8                	neg    %eax
 752:	89 45 ec             	mov    %eax,-0x14(%ebp)
 755:	eb 06                	jmp    75d <printint+0x3c>
  } else {
    x = xx;
 757:	8b 45 0c             	mov    0xc(%ebp),%eax
 75a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 75d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 764:	8b 5d 10             	mov    0x10(%ebp),%ebx
 767:	8b 45 ec             	mov    -0x14(%ebp),%eax
 76a:	ba 00 00 00 00       	mov    $0x0,%edx
 76f:	f7 f3                	div    %ebx
 771:	89 d3                	mov    %edx,%ebx
 773:	8b 45 f4             	mov    -0xc(%ebp),%eax
 776:	8d 50 01             	lea    0x1(%eax),%edx
 779:	89 55 f4             	mov    %edx,-0xc(%ebp)
 77c:	0f b6 94 19 0c 00 00 	movzbl 0xc(%ecx,%ebx,1),%edx
 783:	00 
 784:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 788:	8b 5d 10             	mov    0x10(%ebp),%ebx
 78b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 78e:	ba 00 00 00 00       	mov    $0x0,%edx
 793:	f7 f3                	div    %ebx
 795:	89 45 ec             	mov    %eax,-0x14(%ebp)
 798:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 79c:	75 c6                	jne    764 <printint+0x43>
  if(neg)
 79e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7a2:	74 2d                	je     7d1 <printint+0xb0>
    buf[i++] = '-';
 7a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a7:	8d 50 01             	lea    0x1(%eax),%edx
 7aa:	89 55 f4             	mov    %edx,-0xc(%ebp)
 7ad:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 7b2:	eb 1d                	jmp    7d1 <printint+0xb0>
    putc(fd, buf[i]);
 7b4:	8d 55 dc             	lea    -0x24(%ebp),%edx
 7b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ba:	01 d0                	add    %edx,%eax
 7bc:	0f b6 00             	movzbl (%eax),%eax
 7bf:	0f be c0             	movsbl %al,%eax
 7c2:	83 ec 08             	sub    $0x8,%esp
 7c5:	50                   	push   %eax
 7c6:	ff 75 08             	push   0x8(%ebp)
 7c9:	e8 20 ff ff ff       	call   6ee <putc>
 7ce:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 7d1:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 7d5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7d9:	79 d9                	jns    7b4 <printint+0x93>
}
 7db:	90                   	nop
 7dc:	90                   	nop
 7dd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 7e0:	c9                   	leave  
 7e1:	c3                   	ret    

000007e2 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 7e2:	55                   	push   %ebp
 7e3:	89 e5                	mov    %esp,%ebp
 7e5:	53                   	push   %ebx
 7e6:	83 ec 24             	sub    $0x24,%esp
 7e9:	e8 8f fb ff ff       	call   37d <__x86.get_pc_thunk.bx>
 7ee:	81 c3 5e 07 00 00    	add    $0x75e,%ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 7f4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 7fb:	8d 45 0c             	lea    0xc(%ebp),%eax
 7fe:	83 c0 04             	add    $0x4,%eax
 801:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 804:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 80b:	e9 5b 01 00 00       	jmp    96b <printf+0x189>
    c = fmt[i] & 0xff;
 810:	8b 55 0c             	mov    0xc(%ebp),%edx
 813:	8b 45 f0             	mov    -0x10(%ebp),%eax
 816:	01 d0                	add    %edx,%eax
 818:	0f b6 00             	movzbl (%eax),%eax
 81b:	0f be c0             	movsbl %al,%eax
 81e:	25 ff 00 00 00       	and    $0xff,%eax
 823:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 826:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 82a:	75 2c                	jne    858 <printf+0x76>
      if(c == '%'){
 82c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 830:	75 0c                	jne    83e <printf+0x5c>
        state = '%';
 832:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 839:	e9 29 01 00 00       	jmp    967 <printf+0x185>
      } else {
        putc(fd, c);
 83e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 841:	0f be c0             	movsbl %al,%eax
 844:	83 ec 08             	sub    $0x8,%esp
 847:	50                   	push   %eax
 848:	ff 75 08             	push   0x8(%ebp)
 84b:	e8 9e fe ff ff       	call   6ee <putc>
 850:	83 c4 10             	add    $0x10,%esp
 853:	e9 0f 01 00 00       	jmp    967 <printf+0x185>
      }
    } else if(state == '%'){
 858:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 85c:	0f 85 05 01 00 00    	jne    967 <printf+0x185>
      if(c == 'd'){
 862:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 866:	75 1e                	jne    886 <printf+0xa4>
        printint(fd, *ap, 10, 1);
 868:	8b 45 e8             	mov    -0x18(%ebp),%eax
 86b:	8b 00                	mov    (%eax),%eax
 86d:	6a 01                	push   $0x1
 86f:	6a 0a                	push   $0xa
 871:	50                   	push   %eax
 872:	ff 75 08             	push   0x8(%ebp)
 875:	e8 a7 fe ff ff       	call   721 <printint>
 87a:	83 c4 10             	add    $0x10,%esp
        ap++;
 87d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 881:	e9 da 00 00 00       	jmp    960 <printf+0x17e>
      } else if(c == 'x' || c == 'p'){
 886:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 88a:	74 06                	je     892 <printf+0xb0>
 88c:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 890:	75 1e                	jne    8b0 <printf+0xce>
        printint(fd, *ap, 16, 0);
 892:	8b 45 e8             	mov    -0x18(%ebp),%eax
 895:	8b 00                	mov    (%eax),%eax
 897:	6a 00                	push   $0x0
 899:	6a 10                	push   $0x10
 89b:	50                   	push   %eax
 89c:	ff 75 08             	push   0x8(%ebp)
 89f:	e8 7d fe ff ff       	call   721 <printint>
 8a4:	83 c4 10             	add    $0x10,%esp
        ap++;
 8a7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 8ab:	e9 b0 00 00 00       	jmp    960 <printf+0x17e>
      } else if(c == 's'){
 8b0:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 8b4:	75 45                	jne    8fb <printf+0x119>
        s = (char*)*ap;
 8b6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 8b9:	8b 00                	mov    (%eax),%eax
 8bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 8be:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 8c2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8c6:	75 27                	jne    8ef <printf+0x10d>
          s = "(null)";
 8c8:	8d 83 ce fc ff ff    	lea    -0x332(%ebx),%eax
 8ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while(*s != 0){
 8d1:	eb 1c                	jmp    8ef <printf+0x10d>
          putc(fd, *s);
 8d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8d6:	0f b6 00             	movzbl (%eax),%eax
 8d9:	0f be c0             	movsbl %al,%eax
 8dc:	83 ec 08             	sub    $0x8,%esp
 8df:	50                   	push   %eax
 8e0:	ff 75 08             	push   0x8(%ebp)
 8e3:	e8 06 fe ff ff       	call   6ee <putc>
 8e8:	83 c4 10             	add    $0x10,%esp
          s++;
 8eb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 8ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8f2:	0f b6 00             	movzbl (%eax),%eax
 8f5:	84 c0                	test   %al,%al
 8f7:	75 da                	jne    8d3 <printf+0xf1>
 8f9:	eb 65                	jmp    960 <printf+0x17e>
        }
      } else if(c == 'c'){
 8fb:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 8ff:	75 1d                	jne    91e <printf+0x13c>
        putc(fd, *ap);
 901:	8b 45 e8             	mov    -0x18(%ebp),%eax
 904:	8b 00                	mov    (%eax),%eax
 906:	0f be c0             	movsbl %al,%eax
 909:	83 ec 08             	sub    $0x8,%esp
 90c:	50                   	push   %eax
 90d:	ff 75 08             	push   0x8(%ebp)
 910:	e8 d9 fd ff ff       	call   6ee <putc>
 915:	83 c4 10             	add    $0x10,%esp
        ap++;
 918:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 91c:	eb 42                	jmp    960 <printf+0x17e>
      } else if(c == '%'){
 91e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 922:	75 17                	jne    93b <printf+0x159>
        putc(fd, c);
 924:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 927:	0f be c0             	movsbl %al,%eax
 92a:	83 ec 08             	sub    $0x8,%esp
 92d:	50                   	push   %eax
 92e:	ff 75 08             	push   0x8(%ebp)
 931:	e8 b8 fd ff ff       	call   6ee <putc>
 936:	83 c4 10             	add    $0x10,%esp
 939:	eb 25                	jmp    960 <printf+0x17e>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 93b:	83 ec 08             	sub    $0x8,%esp
 93e:	6a 25                	push   $0x25
 940:	ff 75 08             	push   0x8(%ebp)
 943:	e8 a6 fd ff ff       	call   6ee <putc>
 948:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 94b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 94e:	0f be c0             	movsbl %al,%eax
 951:	83 ec 08             	sub    $0x8,%esp
 954:	50                   	push   %eax
 955:	ff 75 08             	push   0x8(%ebp)
 958:	e8 91 fd ff ff       	call   6ee <putc>
 95d:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 960:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 967:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 96b:	8b 55 0c             	mov    0xc(%ebp),%edx
 96e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 971:	01 d0                	add    %edx,%eax
 973:	0f b6 00             	movzbl (%eax),%eax
 976:	84 c0                	test   %al,%al
 978:	0f 85 92 fe ff ff    	jne    810 <printf+0x2e>
    }
  }
}
 97e:	90                   	nop
 97f:	90                   	nop
 980:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 983:	c9                   	leave  
 984:	c3                   	ret    

00000985 <__x86.get_pc_thunk.cx>:
 985:	8b 0c 24             	mov    (%esp),%ecx
 988:	c3                   	ret    

00000989 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 989:	55                   	push   %ebp
 98a:	89 e5                	mov    %esp,%ebp
 98c:	83 ec 10             	sub    $0x10,%esp
 98f:	e8 e5 f9 ff ff       	call   379 <__x86.get_pc_thunk.ax>
 994:	05 b8 05 00 00       	add    $0x5b8,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
 999:	8b 55 08             	mov    0x8(%ebp),%edx
 99c:	83 ea 08             	sub    $0x8,%edx
 99f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9a2:	8b 90 3c 04 00 00    	mov    0x43c(%eax),%edx
 9a8:	89 55 fc             	mov    %edx,-0x4(%ebp)
 9ab:	eb 24                	jmp    9d1 <free+0x48>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9ad:	8b 55 fc             	mov    -0x4(%ebp),%edx
 9b0:	8b 12                	mov    (%edx),%edx
 9b2:	39 55 fc             	cmp    %edx,-0x4(%ebp)
 9b5:	72 12                	jb     9c9 <free+0x40>
 9b7:	8b 55 f8             	mov    -0x8(%ebp),%edx
 9ba:	3b 55 fc             	cmp    -0x4(%ebp),%edx
 9bd:	77 24                	ja     9e3 <free+0x5a>
 9bf:	8b 55 fc             	mov    -0x4(%ebp),%edx
 9c2:	8b 12                	mov    (%edx),%edx
 9c4:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 9c7:	72 1a                	jb     9e3 <free+0x5a>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9c9:	8b 55 fc             	mov    -0x4(%ebp),%edx
 9cc:	8b 12                	mov    (%edx),%edx
 9ce:	89 55 fc             	mov    %edx,-0x4(%ebp)
 9d1:	8b 55 f8             	mov    -0x8(%ebp),%edx
 9d4:	3b 55 fc             	cmp    -0x4(%ebp),%edx
 9d7:	76 d4                	jbe    9ad <free+0x24>
 9d9:	8b 55 fc             	mov    -0x4(%ebp),%edx
 9dc:	8b 12                	mov    (%edx),%edx
 9de:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 9e1:	73 ca                	jae    9ad <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 9e3:	8b 55 f8             	mov    -0x8(%ebp),%edx
 9e6:	8b 52 04             	mov    0x4(%edx),%edx
 9e9:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
 9f0:	8b 55 f8             	mov    -0x8(%ebp),%edx
 9f3:	01 d1                	add    %edx,%ecx
 9f5:	8b 55 fc             	mov    -0x4(%ebp),%edx
 9f8:	8b 12                	mov    (%edx),%edx
 9fa:	39 d1                	cmp    %edx,%ecx
 9fc:	75 24                	jne    a22 <free+0x99>
    bp->s.size += p->s.ptr->s.size;
 9fe:	8b 55 f8             	mov    -0x8(%ebp),%edx
 a01:	8b 4a 04             	mov    0x4(%edx),%ecx
 a04:	8b 55 fc             	mov    -0x4(%ebp),%edx
 a07:	8b 12                	mov    (%edx),%edx
 a09:	8b 52 04             	mov    0x4(%edx),%edx
 a0c:	01 d1                	add    %edx,%ecx
 a0e:	8b 55 f8             	mov    -0x8(%ebp),%edx
 a11:	89 4a 04             	mov    %ecx,0x4(%edx)
    bp->s.ptr = p->s.ptr->s.ptr;
 a14:	8b 55 fc             	mov    -0x4(%ebp),%edx
 a17:	8b 12                	mov    (%edx),%edx
 a19:	8b 0a                	mov    (%edx),%ecx
 a1b:	8b 55 f8             	mov    -0x8(%ebp),%edx
 a1e:	89 0a                	mov    %ecx,(%edx)
 a20:	eb 0a                	jmp    a2c <free+0xa3>
  } else
    bp->s.ptr = p->s.ptr;
 a22:	8b 55 fc             	mov    -0x4(%ebp),%edx
 a25:	8b 0a                	mov    (%edx),%ecx
 a27:	8b 55 f8             	mov    -0x8(%ebp),%edx
 a2a:	89 0a                	mov    %ecx,(%edx)
  if(p + p->s.size == bp){
 a2c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 a2f:	8b 52 04             	mov    0x4(%edx),%edx
 a32:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
 a39:	8b 55 fc             	mov    -0x4(%ebp),%edx
 a3c:	01 ca                	add    %ecx,%edx
 a3e:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 a41:	75 20                	jne    a63 <free+0xda>
    p->s.size += bp->s.size;
 a43:	8b 55 fc             	mov    -0x4(%ebp),%edx
 a46:	8b 4a 04             	mov    0x4(%edx),%ecx
 a49:	8b 55 f8             	mov    -0x8(%ebp),%edx
 a4c:	8b 52 04             	mov    0x4(%edx),%edx
 a4f:	01 d1                	add    %edx,%ecx
 a51:	8b 55 fc             	mov    -0x4(%ebp),%edx
 a54:	89 4a 04             	mov    %ecx,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 a57:	8b 55 f8             	mov    -0x8(%ebp),%edx
 a5a:	8b 0a                	mov    (%edx),%ecx
 a5c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 a5f:	89 0a                	mov    %ecx,(%edx)
 a61:	eb 08                	jmp    a6b <free+0xe2>
  } else
    p->s.ptr = bp;
 a63:	8b 55 fc             	mov    -0x4(%ebp),%edx
 a66:	8b 4d f8             	mov    -0x8(%ebp),%ecx
 a69:	89 0a                	mov    %ecx,(%edx)
  freep = p;
 a6b:	8b 55 fc             	mov    -0x4(%ebp),%edx
 a6e:	89 90 3c 04 00 00    	mov    %edx,0x43c(%eax)
}
 a74:	90                   	nop
 a75:	c9                   	leave  
 a76:	c3                   	ret    

00000a77 <morecore>:

static Header*
morecore(uint nu)
{
 a77:	55                   	push   %ebp
 a78:	89 e5                	mov    %esp,%ebp
 a7a:	53                   	push   %ebx
 a7b:	83 ec 14             	sub    $0x14,%esp
 a7e:	e8 fa f8 ff ff       	call   37d <__x86.get_pc_thunk.bx>
 a83:	81 c3 c9 04 00 00    	add    $0x4c9,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 a89:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 a90:	77 07                	ja     a99 <morecore+0x22>
    nu = 4096;
 a92:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 a99:	8b 45 08             	mov    0x8(%ebp),%eax
 a9c:	c1 e0 03             	shl    $0x3,%eax
 a9f:	83 ec 0c             	sub    $0xc,%esp
 aa2:	50                   	push   %eax
 aa3:	e8 26 fc ff ff       	call   6ce <sbrk>
 aa8:	83 c4 10             	add    $0x10,%esp
 aab:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 aae:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 ab2:	75 07                	jne    abb <morecore+0x44>
    return 0;
 ab4:	b8 00 00 00 00       	mov    $0x0,%eax
 ab9:	eb 27                	jmp    ae2 <morecore+0x6b>
  hp = (Header*)p;
 abb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 abe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 ac1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 ac4:	8b 55 08             	mov    0x8(%ebp),%edx
 ac7:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 aca:	8b 45 f0             	mov    -0x10(%ebp),%eax
 acd:	83 c0 08             	add    $0x8,%eax
 ad0:	83 ec 0c             	sub    $0xc,%esp
 ad3:	50                   	push   %eax
 ad4:	e8 b0 fe ff ff       	call   989 <free>
 ad9:	83 c4 10             	add    $0x10,%esp
  return freep;
 adc:	8b 83 3c 04 00 00    	mov    0x43c(%ebx),%eax
}
 ae2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 ae5:	c9                   	leave  
 ae6:	c3                   	ret    

00000ae7 <malloc>:

void*
malloc(uint nbytes)
{
 ae7:	55                   	push   %ebp
 ae8:	89 e5                	mov    %esp,%ebp
 aea:	53                   	push   %ebx
 aeb:	83 ec 14             	sub    $0x14,%esp
 aee:	e8 8a f8 ff ff       	call   37d <__x86.get_pc_thunk.bx>
 af3:	81 c3 59 04 00 00    	add    $0x459,%ebx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 af9:	8b 45 08             	mov    0x8(%ebp),%eax
 afc:	83 c0 07             	add    $0x7,%eax
 aff:	c1 e8 03             	shr    $0x3,%eax
 b02:	83 c0 01             	add    $0x1,%eax
 b05:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 b08:	8b 83 3c 04 00 00    	mov    0x43c(%ebx),%eax
 b0e:	89 45 f0             	mov    %eax,-0x10(%ebp)
 b11:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 b15:	75 28                	jne    b3f <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
 b17:	8d 83 34 04 00 00    	lea    0x434(%ebx),%eax
 b1d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 b20:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b23:	89 83 3c 04 00 00    	mov    %eax,0x43c(%ebx)
 b29:	8b 83 3c 04 00 00    	mov    0x43c(%ebx),%eax
 b2f:	89 83 34 04 00 00    	mov    %eax,0x434(%ebx)
    base.s.size = 0;
 b35:	c7 83 38 04 00 00 00 	movl   $0x0,0x438(%ebx)
 b3c:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b42:	8b 00                	mov    (%eax),%eax
 b44:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 b47:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b4a:	8b 40 04             	mov    0x4(%eax),%eax
 b4d:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 b50:	77 4e                	ja     ba0 <malloc+0xb9>
      if(p->s.size == nunits)
 b52:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b55:	8b 40 04             	mov    0x4(%eax),%eax
 b58:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 b5b:	75 0c                	jne    b69 <malloc+0x82>
        prevp->s.ptr = p->s.ptr;
 b5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b60:	8b 10                	mov    (%eax),%edx
 b62:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b65:	89 10                	mov    %edx,(%eax)
 b67:	eb 26                	jmp    b8f <malloc+0xa8>
      else {
        p->s.size -= nunits;
 b69:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b6c:	8b 40 04             	mov    0x4(%eax),%eax
 b6f:	2b 45 ec             	sub    -0x14(%ebp),%eax
 b72:	89 c2                	mov    %eax,%edx
 b74:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b77:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 b7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b7d:	8b 40 04             	mov    0x4(%eax),%eax
 b80:	c1 e0 03             	shl    $0x3,%eax
 b83:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 b86:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b89:	8b 55 ec             	mov    -0x14(%ebp),%edx
 b8c:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 b8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b92:	89 83 3c 04 00 00    	mov    %eax,0x43c(%ebx)
      return (void*)(p + 1);
 b98:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b9b:	83 c0 08             	add    $0x8,%eax
 b9e:	eb 3c                	jmp    bdc <malloc+0xf5>
    }
    if(p == freep)
 ba0:	8b 83 3c 04 00 00    	mov    0x43c(%ebx),%eax
 ba6:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 ba9:	75 1e                	jne    bc9 <malloc+0xe2>
      if((p = morecore(nunits)) == 0)
 bab:	83 ec 0c             	sub    $0xc,%esp
 bae:	ff 75 ec             	push   -0x14(%ebp)
 bb1:	e8 c1 fe ff ff       	call   a77 <morecore>
 bb6:	83 c4 10             	add    $0x10,%esp
 bb9:	89 45 f4             	mov    %eax,-0xc(%ebp)
 bbc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 bc0:	75 07                	jne    bc9 <malloc+0xe2>
        return 0;
 bc2:	b8 00 00 00 00       	mov    $0x0,%eax
 bc7:	eb 13                	jmp    bdc <malloc+0xf5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bc9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bcc:	89 45 f0             	mov    %eax,-0x10(%ebp)
 bcf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bd2:	8b 00                	mov    (%eax),%eax
 bd4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 bd7:	e9 6b ff ff ff       	jmp    b47 <malloc+0x60>
  }
}
 bdc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 bdf:	c9                   	leave  
 be0:	c3                   	ret    

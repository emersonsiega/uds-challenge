# uds-challenge

Aplicativo para cadastro e visualização de pautas.

Desenvolvido com:

- Flutter versão 1.12.13+hotfix.9
- [slidy](https://pub.dev/packages/slidy) e [bloc_pattern](https://pub.dev/packages/bloc_pattern)
- [Firebase Auth](https://pub.dev/packages/firebase_auth)
- [Firebase Database](https://pub.dev/packages/firebase_database)
- [SendGrid](https://sendgrid.com/)

## Firebase

### Auth

Foi utilizado o módulo de authentication do Firebase para fazer o controle de usuários por email e senha.

### Realtime Database

Foi escolhido o banco de dados realtime do Firebase pela sua simplicidade.

Os dados foram organizados na seguinte estrutura:

```json
{
  "topics": {
    "-M9p0lBhnfhacOCLg48y": {
      "author": "Emerson Siega",
      "closed": false,
      "createdAt": 1592175039277,
      "description": "Breve descrição da pauta",
      "details": "Descrição completa da pauta.\n\nPodendo ter quebras de linha e emojis 😀😀",
      "title": "Título da pauta",
      "userKey": "-M9p0SpO_-_WpvKEL_Oj"
    }
  },
  "users": {
    "-M9p0SpO_-_WpvKEL_Oj": {
      "authId": "LPYzEPxg2jSfaKnDqHNgcu95IZo2",
      "email": "emersonsiega@hotmail.com",
      "name": "Emerson Siega",
      "password": "SNwfukzUBetcYBLYHa/7cQ=="
    }
  }
}
```

### SendGrid

Foi escolhido o SendGrid para fazer o envio de emails de recuperação de senha.

[Aparentemente alguns IP's da free tier desse serviço estão na blacklist do Outlook](https://github.com/sendgrid/docs/issues/3939) (destinatários @hotmail, @live e @outlook), podendo não ser enviados ou caírem no spam.

Então, para se ter uma melhor experiência, pede-se que sejam utilizados e-mails de outros provedores para testes.

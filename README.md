Este pacote reúne alguns widgets úteis usados no app Lista10.

## Features

* ImageWidget: Widget que mostra uma imagem com um ícone de edição e 2 botões dentro de um modal quando o usuário clica na imagem para alterar. Os botões oferecem a opção de troca da imagem usando outra imagem da galeria ou câmera.

* NewItemWidget: Widget com modal apresentado em várias telas no botão de adição de item. Um widget simples onde é capturado o título de um novo item e uma cor de forma opcional.

## Por onde começar

Para usar este pacote adicione-o na sessão `dependencies` do seu `pubspec.yaml`:

- Via github (mais recomendado)
```yaml
dependencies:
lista10_package: 
    git:
      url: https://github.com/danieldsdias/lista10_package
      ref: main
```

- Clonando o repositório em uma pasta relativa à localização do seu projeto
```yaml
dependencies:
lista10_package: 
    path: ../lista10_package
```

Feito isso, rode o comando na raiz do seu projeto:

```shell
flutter pub get
```

## Uso

Um exemplo de uso pode ser visualizado em [/example/lib/main.dart](https://github.com/danieldsdias/lista10_package/blob/main/example/lib/main.dart)

## Informação adicional

Faz uso dos seguintes pacotes:
- [flutter_material_color_picker](https://pub.dev/packages/flutter_material_color_picker)
- [image_picker](https://pub.dev/packages/image_picker)

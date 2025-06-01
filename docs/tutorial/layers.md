---
title: Layer Catalogue
---

# Layers

To create a Caffe model you need to define the model architecture in a protocol buffer definition file (prototxt).

Caffe layers and their parameters are defined in the protocol buffer definitions for the project in [caffe.proto](https://github.com/BVLC/caffe/blob/master/src/caffe/proto/caffe.proto).

## Data Layers

Data enters Caffe through data layers: they lie at the bottom of nets. Data can come from efficient databases (LevelDB or LMDB), directly from memory, or, when efficiency is not critical, from files on disk in HDF5 or common image formats.

Common input preprocessing (mean subtraction, scaling, random cropping, and mirroring) is available by specifying `TransformationParameter`s by some of the layers.
The [bias](layers/bias.md), [scale](layers/scale.md), and [crop](layers/crop.md) layers can be helpful with transforming the inputs, when `TransformationParameter` isn't available.

Layers:

* [Image Data](layers/imagedata.md) - read raw images.
* [Database](layers/data.md) - read data from LEVELDB or LMDB.
* [HDF5 Input](layers/hdf5data.md) - read HDF5 data, allows data of arbitrary dimensions.
* [HDF5 Output](layers/hdf5output.md) - write data as HDF5.
* [Input](layers/input.md) - typically used for networks that are being deployed.
* [Window Data](layers/windowdata.md) - read window data file.
* [Memory Data](layers/memorydata.md) - read data directly from memory.
* [Dummy Data](layers/dummydata.md) - for static data and debugging.

Note that the [Python](layers/python.md) Layer can be useful for create custom data layers.

## Vision Layers

Vision layers usually take *images* as input and produce other *images* as output, although they can take data of other types and dimensions.
A typical "image" in the real-world may have one color channel ($$c = 1$$), as in a grayscale image, or three color channels ($$c = 3$$) as in an RGB (red, green, blue) image.
But in this context, the distinguishing characteristic of an image is its spatial structure: usually an image has some non-trivial height $$h > 1$$ and width $$w > 1$$.
This 2D geometry naturally lends itself to certain decisions about how to process the input.
In particular, most of the vision layers work by applying a particular operation to some region of the input to produce a corresponding region of the output.
In contrast, other layers (with few exceptions) ignore the spatial structure of the input, effectively treating it as "one big vector" with dimension $$chw$$.

Layers:

* [Convolution Layer](layers/convolution.md) - convolves the input image with a set of learnable filters, each producing one feature map in the output image.
* [Pooling Layer](layers/pooling.md) - max, average, or stochastic pooling.
* [Spatial Pyramid Pooling (SPP)](layers/spp.md)
* [Crop](layers/crop.md) - perform cropping transformation.
* [Deconvolution Layer](layers/deconvolution.md) - transposed convolution.

* [Im2Col](layers/im2col.md) - relic helper layer that is not used much anymore.

## Recurrent Layers

Layers:

* [Recurrent](layers/recurrent.md)
* [RNN](layers/rnn.md)
* [Long-Short Term Memory (LSTM)](layers/lstm.md)

## Common Layers

Layers:

* [Inner Product](layers/innerproduct.md) - fully connected layer.
* [Dropout](layers/dropout.md)
* [Embed](layers/embed.md) - for learning embeddings of one-hot encoded vector (takes index as input).

## Normalization Layers

* [Local Response Normalization (LRN)](layers/lrn.md) - performs a kind of "lateral inhibition" by normalizing over local input regions.
* [Mean Variance Normalization (MVN)](layers/mvn.md) - performs contrast normalization / instance normalization.
* [Batch Normalization](layers/batchnorm.md) - performs normalization over mini-batches.

The [bias](layers/bias.md) and [scale](layers/scale.md) layers can be helpful in combination with normalization.

## Activation / Neuron Layers

In general, activation / Neuron layers are element-wise operators, taking one bottom blob and producing one top blob of the same size. In the layers below, we will ignore the input and out sizes as they are identical:

* Input
    - n * c * h * w
* Output
    - n * c * h * w

Layers:

* [ReLU / Rectified-Linear and Leaky-ReLU](layers/relu.md) - ReLU and Leaky-ReLU rectification.
* [PReLU](layers/prelu.md) - parametric ReLU.
* [ELU](layers/elu.md) - exponential linear rectification.
* [Sigmoid](layers/sigmoid.md)
* [TanH](layers/tanh.md)
* [Absolute Value](layers/absval.md)
* [Power](layers/power.md) - f(x) = (shift + scale * x) ^ power.
* [Exp](layers/exp.md) - f(x) = base ^ (shift + scale * x).
* [Log](layers/log.md) - f(x) = log(x).
* [BNLL](layers/bnll.md) - f(x) = log(1 + exp(x)).
* [Threshold](layers/threshold.md) - performs step function at user defined threshold.
* [Clip](layers/clip.md) - clips a blob between a fixed minimum and maximum value.
* [Bias](layers/bias.md) - adds a bias to a blob that can either be learned or fixed.
* [Scale](layers/scale.md) - scales a blob by an amount that can either be learned or fixed.

## Utility Layers

Layers:

* [Flatten](layers/flatten.md)
* [Reshape](layers/reshape.md)
* [Batch Reindex](layers/batchreindex.md)

* [Split](layers/split.md)
* [Concat](layers/concat.md)
* [Slicing](layers/slice.md)
* [Eltwise](layers/eltwise.md) - element-wise operations such as product or sum between two blobs.
* [Filter / Mask](layers/filter.md) - mask or select output using last blob.
* [Parameter](layers/parameter.md) - enable parameters to be shared between layers.
* [Reduction](layers/reduction.md) - reduce input blob to scalar blob using operations such as sum or mean.
* [Silence](layers/silence.md) - prevent top-level blobs from being printed during training.

* [ArgMax](layers/argmax.md)
* [Softmax](layers/softmax.md)

* [Python](layers/python.md) - allows custom Python layers.

## Loss Layers

Loss drives learning by comparing an output to a target and assigning cost to minimize. The loss itself is computed by the forward pass and the gradient w.r.t. to the loss is computed by the backward pass.

Layers:

* [Multinomial Logistic Loss](layers/multinomiallogisticloss.md)
* [Infogain Loss](layers/infogainloss.md) - a generalization of MultinomialLogisticLossLayer.
* [Softmax with Loss](layers/softmaxwithloss.md) - computes the multinomial logistic loss of the softmax of its inputs. It's conceptually identical to a softmax layer followed by a multinomial logistic loss layer, but provides a more numerically stable gradient.
* [Sum-of-Squares / Euclidean](layers/euclideanloss.md) - computes the sum of squares of differences of its two inputs, $$\frac 1 {2N} \sum_{i=1}^N \| x^1_i - x^2_i \|_2^2$$.
* [Hinge / Margin](layers/hingeloss.md) - The hinge loss layer computes a one-vs-all hinge (L1) or squared hinge loss (L2).
* [Sigmoid Cross-Entropy Loss](layers/sigmoidcrossentropyloss.md) - computes the cross-entropy (logistic) loss, often used for predicting targets interpreted as probabilities.
* [Accuracy / Top-k layer](layers/accuracy.md) - scores the output as an accuracy with respect to target -- it is not actually a loss and has no backward step.
* [Contrastive Loss](layers/contrastiveloss.md)


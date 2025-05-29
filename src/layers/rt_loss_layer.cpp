#include <algorithm>
#include <vector>

#include "caffe/layers/rt_loss_layer.hpp"
#include "caffe/util/math_functions.hpp"

namespace caffe {
    
    template <typename Dtype>
    void RTLossLayer<Dtype>::LayerSetUp(
	const vector<Blob<Dtype>*>& bottom, const vector<Blob<Dtype>*>& top) {
	Layer<Dtype>::LayerSetUp(bottom, top);
    }
    
    template <typename Dtype>
    void RTLossLayer<Dtype>::Reshape(
	const vector<Blob<Dtype>*>& bottom, const vector<Blob<Dtype>*>& top) {
	vector<int> loss_shape(0);  // Loss layers output a scalar; 0 axes.
	top[0]->Reshape(loss_shape);
    }
    
    template <typename Dtype>
    void RTLossLayer<Dtype>::Forward_cpu(
	const vector<Blob<Dtype>*>& bottom, const vector<Blob<Dtype>*>& top) {
	top[0]->mutable_cpu_data()[0] = loss;
    }
    
    template <typename Dtype>
    void RTLossLayer<Dtype>::Backward_cpu(
	const vector<Blob<Dtype>*>& top, const vector<bool>& propagate_down,
	const vector<Blob<Dtype>*>& bottom) {
    }

#ifdef CPU_ONLY
    STUB_GPU(RTLossLayer);
#endif
    
    INSTANTIATE_CLASS(RTLossLayer);
    REGISTER_LAYER_CLASS(RTLoss);
    
}  // namespace caffe

<template>
    <div class="productManager-container">
        <div class="PM-header">
            <h2>Product Manager</h2>
        </div>

        <div class="addProd-container">
            <form @submit="submitForm">
                <!-- Photo Upload -->
                <input type="file" @change="handleFileChange" />

                <!-- Type -->
                <select v-model="productType">
                    <option value="physical">Physical</option>
                    <option value="digital">Digital</option>
                </select>

                <!-- Name -->
                <input type="text" v-model="name" placeholder="Product Name" />

                <!-- Description -->
                <textarea v-model="description" placeholder="Description"></textarea>

                <!-- Category -->
                <input type="text" v-model="category" placeholder="Category" />

                <!-- Price -->
                <input type="number" v-model="price" placeholder="Price" />

                <button type="submit">Add Product</button>
            </form>
        </div>
    </div>
</template>
